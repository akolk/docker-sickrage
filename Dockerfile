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

COPY .blank tmp/qemu-$ARCH-static* /usr/bin/

RUN apk update && \
    apk upgrade && \
    apk add git python2 nodejs && \
    rm -rf /var/cache/apk/*

RUN git clone --depth=1 https://github.com/SickRage/SickRage.git /app/sickrage

ADD config.ini /config/config.ini

# ports and volumes
EXPOSE 8081
VOLUME /config /volumes/media

CMD ["python", "/app/sickrage/SickBeard.py", "--datadir", "/config"]
