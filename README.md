[hub]: https://hub.docker.com/r/carlosedp/sickrage/

# carlosedp/sickrage

[![Build Status](https://travis-ci.org/carlosedp/docker-sickrage.svg?branch=master)](https://travis-ci.org/carlosedp/docker-sickrage)[![](https://images.microbadger.com/badges/image/carlosedp/sickrage.svg)](https://microbadger.com/images/carlosedp/sickrage "Get your own image badge on microbadger.com")

Automatic Video Library Manager for TV Shows. It watches for new episodes of your favorite shows, and when they are posted it does its magic. [Sickrage](https://sickrage.github.io/)

## Usage

### Media Folder Structure

The containers expect a similar structure with Downloads, Incomplete, Movies, TVShows and Concerts directories on your drive.

    /mnt/external/Downloads/
                            /Incomplete
                            /Movies
                            /TVShows
                  /Movies/
                  /TVShows/
                  /Concerts/

To make all applications behave similarly, the external volume will be mounted on `/volumes/media` in the container.

    export MEDIA=/mnt/1TB-WDred

```
    docker volume create sickrage_config
    docker run -d \
    --name=sickrage \
    --restart=unless-stopped \
    --net=mediaserver \
    -v sickrage_config:/config \
    -v $MEDIA:/volumes/media \
    -v /etc/localtime:/etc/localtime:ro \
    -e PGID=1000 -e PUID=1000  \
    -p 8081:8081 \
    carlosedp/sickrage
```

## Parameters

`The parameters are split into two halves, separated by a colon, the left hand side representing the host and the right the container side. 
For example with a port -p external:internal - what this shows is the port mapping from internal to external of the container.
So -p 8080:80 would expose port 80 from inside the container to be accessible from the host's IP on port 8080
http://192.168.x.x:8080 would show you what's running INSIDE the container on port 80.`


* `-p 8081` - the port(s)
* `-v /config` - where sickrage should store config files. Defaults to a Docker volume
* `-v $MEDIA:/volumes/media` - your media folder.
* `-e PGID` for GroupID - see below for explanation
* `-e PUID` for UserID - see below for explanation

It is based on alpine linux with s6 overlay, for shell access whilst the container is running do `docker exec -it sickrage /bin/sh`.

### User / Group Identifiers

Sometimes when using data volumes (`-v` flags) permissions issues can arise between the host OS and the container. We avoid this issue by allowing you to specify the user `PUID` and group `PGID`. Ensure the data volume directory on the host is owned by the same user you specify and it will "just work" ™.

In this instance `PUID=1001` and `PGID=1001`. To find yours use `id user` as below:

```
  $ id <dockeruser>
    uid=1001(dockeruser) gid=1001(dockergroup) groups=1001(dockergroup)
```

## Setting up the application 

Web interface is at `<your ip>:8081` , set paths for downloads, tv-shows to match docker mappings via the webui.

## Info

* To monitor the logs of the container in realtime `docker logs -f sickrage`.

* container version number 

`docker inspect -f '{{ index .Config.Labels "build_version" }}' sickrage`

* image version number

`docker inspect -f '{{ index .Config.Labels "build_version" }}' linuxserver/sickrage`
