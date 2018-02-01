ARG target=amd64
FROM $target/alpine

# set version label
LABEL maintainer="carlosedp"

ARG arch=amd64
ENV ARCH=$arch

# set python to use utf-8 rather than ascii
ENV PYTHONIOENCODING="UTF-8"
# > At the moment, setting "LANG=C" on a Linux system *fundamentally breaks Python 3*, and that's not OK.
ENV LANG C.UTF-8

# install ca-certificates so that HTTPS works consistently
# the other runtime dependencies for Python are installed later
RUN apk add --no-cache ca-certificates

COPY tmp/qemu-$ARCH-static /usr/bin/qemu-$ARCH-static

RUN apk update && \
    apk upgrade && \
    apk add git python2 && \
    rm -rf /var/cache/apk/*

RUN git clone --depth=1 https://github.com/SickRage/SickRage.git /app/sickrage

ADD config.ini /config/config.ini

# ports and volumes
EXPOSE 8081
VOLUME /config /volumes/media

CMD ["python", "/app/sickrage/SickBeard.py", "--datadir", "/config"]
