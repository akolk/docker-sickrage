FROM python:2.7-alpine3.7

# set version label
LABEL maintainer="carlosedp"

# set python to use utf-8 rather than ascii
ENV PYTHONIOENCODING="UTF-8"

RUN apk update && \
    apk upgrade && \
    apk add git && \
    rm -rf /var/cache/apk/*

RUN git clone --depth=1 https://github.com/SickRage/SickRage.git /app/sickrage

ADD config.ini /config/config.ini

# ports and volumes
EXPOSE 8081
VOLUME /config /downloads /tv

CMD ["python", "/app/sickrage/SickBeard.py", "--datadir", "/config"]
