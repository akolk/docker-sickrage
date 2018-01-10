FROM python:2.7-alpine3.7

# set version label
LABEL maintainer="carlosedp"

# set python to use utf-8 rather than ascii
ENV PYTHONIOENCODING="UTF-8"

RUN apk update && \
    apk upgrade && \
    apk add git

RUN \
 echo "**** install app ****" && \
 git clone --depth=1 https://github.com/SickRage/SickRage.git /app/sickrage

# copy local files
COPY root/ /

# ports and volumes
EXPOSE 8081
VOLUME /config /downloads /tv
