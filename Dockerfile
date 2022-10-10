FROM ghcr.io/linuxserver/baseimage-alpine:3.15

# set version label
ARG BUILD_DATE
ARG VERSION
ARG NNTP2NNTP_RELEASE
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="chbmb"

# install build packages
RUN \
  apk add --no-cache --virtual=build-dependencies \
    cargo \
    g++ \
    gcc \
    libffi-dev \
    libressl-dev \
    make \
    musl-dev \
    openssl-dev \
    python2-dev \
    tar && \
  # install runtime packages
  apk add --no-cache \
    libffi \
    libressl \
    python2 && \
    curl -o /tmp/get-pip.py https://bootstrap.pypa.io/pip/2.7/get-pip.py && \
  python /tmp/get-pip.py && \ 
  # install nntp2nntp via pip package manager
  if [ -z ${NNTP2NNTP_RELEASE+x} ]; then \
    NNTP2NNTP_RELEASE=$(curl -sX GET "https://api.github.com/repos/linuxserver/nntp2nntp/releases/latest" \
  | awk '/tag_name/{print $4;exit}' FS='[""]'); \
  fi && \
  pip install --no-cache-dir -U --find-links https://wheel-index.linuxserver.io/alpine-3.15/ \
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
