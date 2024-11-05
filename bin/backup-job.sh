#! /usr/bin/env bash


JOB_NAME=$1
USER=$2
PASSWORD=$3

function usage() {
	echo "$0 <JOB_NAME> <USER> <PASSWORD>"
}

if [[ -z "$JOB_NAME" ]]; then
	echo "Job name is required." 2>&1
	usage
	exit 1
fi

if [[ -z "$USER" ]]; then
	echo "USER is required." 2>&1
	usage
	exit 1
fi

if [[ -z "$PASSWORD" ]]; then
	echo "PASSWORD is required." 2>&1
	usage
	exit 1
fi

if [[ ! $(docker compose exec jenkins test -f jenkins-cli.jar) ]]; then
	docker compose exec jenkins curl --silent -O http://localhost:8080/jnlpJars/jenkins-cli.jar
fi

FILENAME=$(echo $JOB_NAME | tr ' ' '_')

docker compose exec jenkins java -jar jenkins-cli.jar -s http://localhost:8080/ -auth $USER:$PASSWORD get-job "$JOB_NAME" >  ${FILENAME}.xml

if [ $? -eq 0 ]; then
	echo "Backup complete! Backed up to \"$FILENAME\".xml"
else
	echo "Backup failed!"
fi
