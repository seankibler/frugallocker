FROM jenkins/jenkins:2.479.1-lts

USER root

ARG YT_DLP_VERSION=2024.10.22
ARG YT_DLP_PLATFORM=linux
ARG YT_DLP_SHA256=dcca6afb6ac9770d4d3425c35e415f4a8fc69b626c60f12ca899bfc05f6a72fc

RUN curl -LO https://github.com/yt-dlp/yt-dlp/releases/download/${YT_DLP_VERSION}/yt-dlp_${YT_DLP_PLATFORM} && \
	echo "${YT_DLP_SHA256}  yt-dlp_${YT_DLP_PLATFORM}" | sha256sum -c && \
	mv yt-dlp_${YT_DLP_PLATFORM} /usr/local/bin/yt-dlp && \
	chmod 0755 /usr/local/bin/yt-dlp

USER ${user}
