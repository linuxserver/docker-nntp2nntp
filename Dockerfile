FROM lsiobase/alpine:3.9
MAINTAINER sparklyballs

# set version label
ARG BUILD_DATE
ARG VERSION
ARG NNTP2NNTP_RELEASE
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"

# install build packages
RUN \
 apk add --no-cache --virtual=build-dependencies \
	curl \
	g++ \
	gcc \
	libffi-dev \
	libressl-dev \
	make \
	python2-dev \
	tar && \
# install runtime packages
 apk add --no-cache \
	libffi \
	libressl \
	py2-pip && \
# install nntp2nntp via pip package manager
 if [ -z ${NNTP2NNTP_RELEASE+x} ]; then \
	NNTP2NNTP_RELEASE=$(curl -sX GET https://api.github.com/repos/linuxserver/nntp2nntp/commits/master \
	| awk '/sha/{print $4;exit}' FS='[""]'); \
 fi && \
 pip install --no-cache-dir -U \
	https://github.com/linuxserver/nntp2nntp/archive/${NNTP2NNTP_RELEASE}.tar.gz \
	service_identity && \
# cleanup
 apk del --purge \
	build-dependencies && \
 rm -rf \
	/root/.cache \
	/tmp/*
# add local files
COPY root/ /
# ports and volumes
EXPOSE 1563
VOLUME /config
