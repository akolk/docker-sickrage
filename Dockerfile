ARG target=amd64
FROM $target/python:2.7-alpine3.7

# set version label
LABEL maintainer="carlosedp"

ARG arch=amd64
ENV ARCH=$arch

# set python to use utf-8 rather than ascii
ENV PYTHONIOENCODING="UTF-8"

COPY tmp/qemu-$ARCH-static /usr/bin/qemu-$ARCH-static

RUN apk update && \
    apk upgrade && \
    apk add git && \
    rm -rf /var/cache/apk/*

RUN git clone --depth=1 https://github.com/SickRage/SickRage.git /app/sickrage

ADD config.ini /config/config.ini

# ports and volumes
EXPOSE 8081
VOLUME /config /volumes/media

CMD ["python", "/app/sickrage/SickBeard.py", "--datadir", "/config"]
