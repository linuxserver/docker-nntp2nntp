[![linuxserver.io](https://raw.githubusercontent.com/linuxserver/docker-templates/master/linuxserver.io/img/linuxserver_medium.png)](https://linuxserver.io)

The [LinuxServer.io](https://linuxserver.io) team brings you another container release featuring :-

 * regular and timely application updates
 * easy user mappings (PGID, PUID)
 * custom base image with s6 overlay
 * weekly base OS updates with common layers across the entire LinuxServer.io ecosystem to minimise space usage, down time and bandwidth
 * regular security updates

Find us at:
* [Discord](https://discord.gg/YWrKVTn) - realtime support / chat with the community and the team.
* [IRC](https://irc.linuxserver.io) - on freenode at `#linuxserver.io`. Our primary support channel is Discord.
* [Blog](https://blog.linuxserver.io) - all the things you can do with our containers including How-To guides, opinions and much more!

# [linuxserver/nntp2nntp](https://github.com/linuxserver/docker-nntp2nntp)
[![](https://img.shields.io/discord/354974912613449730.svg?logo=discord&label=LSIO%20Discord&style=flat-square)](https://discord.gg/YWrKVTn)
[![](https://images.microbadger.com/badges/version/linuxserver/nntp2nntp.svg)](https://microbadger.com/images/linuxserver/nntp2nntp "Get your own version badge on microbadger.com")
[![](https://images.microbadger.com/badges/image/linuxserver/nntp2nntp.svg)](https://microbadger.com/images/linuxserver/nntp2nntp "Get your own version badge on microbadger.com")
![Docker Pulls](https://img.shields.io/docker/pulls/linuxserver/nntp2nntp.svg)
![Docker Stars](https://img.shields.io/docker/stars/linuxserver/nntp2nntp.svg)
[![Build Status](https://ci.linuxserver.io/buildStatus/icon?job=Docker-Pipeline-Builders/docker-nntp2nntp/master)](https://ci.linuxserver.io/job/Docker-Pipeline-Builders/job/docker-nntp2nntp/job/master/)
[![](https://lsio-ci.ams3.digitaloceanspaces.com/linuxserver/nntp2nntp/latest/badge.svg)](https://lsio-ci.ams3.digitaloceanspaces.com/linuxserver/nntp2nntp/latest/index.html)

[Nntp2nntp](https://github.com/linuxserver/nntp2nntp) proxy allow you to use your NNTP Account from multiple systems, each with own user name and password. It fully supports SSL and you can also limit the access to proxy with SSL certificates. nntp2nntp proxy is very simple and pretty fast.
## Warning

Whilst we know of no nntp2nntp security issues the [upstream code](https://github.com/linuxserver/nntp2nntp) for this project has received no changes since 06.08.15 and is likely abandoned permanently.  For this reason we strongly recommend you do not make this application public facing and if you must do so other layers of security and SSL should be considered an absolute bare minimum requirement.  We see this proxy being used primarily on a LAN so that all the users NNTP applications can share a common set of internal credentials allowing for central managment of the upstream account e.g change provider, server, thread limits for all applications with one global config change.


[![nntp2nntp](https://raw.githubusercontent.com/linuxserver/docker-templates/master/linuxserver.io/img/nntp2nntp.png)](https://github.com/linuxserver/nntp2nntp)

## Supported Architectures

Our images support multiple architectures such as `x86-64`, `arm64` and `armhf`. We utilise the docker manifest for multi-platform awareness. More information is available from docker [here](https://github.com/docker/distribution/blob/master/docs/spec/manifest-v2-2.md#manifest-list) and our announcement [here](https://blog.linuxserver.io/2019/02/21/the-lsio-pipeline-project/). 

Simply pulling `linuxserver/nntp2nntp` should retrieve the correct image for your arch, but you can also pull specific arch images via tags.

The architectures supported by this image are:

| Architecture | Tag |
| :----: | --- |
| x86-64 | amd64-latest |
| arm64 | arm64v8-latest |
| armhf | arm32v6-latest |


## Usage

Here are some example snippets to help you get started creating a container.

### docker

```
docker create \
  --name=nntp2nntp \
  -e PUID=1000 \
  -e PGID=1000 \
  -e PUID=<yourUID> \
  -e PGID=<yourGID> \
  -e TZ=Europe/London \
  -p 1563:1563 \
  -v <path to data>:/config \
  --restart unless-stopped \
  linuxserver/nntp2nntp
```


### docker-compose

Compatible with docker-compose v2 schemas.

```
---
version: "2"
services:
  nntp2nntp:
    image: linuxserver/nntp2nntp
    container_name: nntp2nntp
    environment:
      - PUID=1000
      - PGID=1000
      - PUID=<yourUID>
      - PGID=<yourGID>
      - TZ=Europe/London
    volumes:
      - <path to data>:/config
    ports:
      - 1563:1563
    restart: unless-stopped
```

## Parameters

Container images are configured using parameters passed at runtime (such as those above). These parameters are separated by a colon and indicate `<external>:<internal>` respectively. For example, `-p 8080:80` would expose port `80` from inside the container to be accessible from the host's IP on port `8080` outside the container.

| Parameter | Function |
| :----: | --- |
| `-p 1563` | will map the container's port 1563 to port 1563 on the host |
| `-e PUID=1000` | for UserID - see below for explanation |
| `-e PGID=1000` | for GroupID - see below for explanation |
| `-e PUID=<yourUID>` | specify your UID |
| `-e PGID=<yourGID>` | specify your GID |
| `-e TZ=Europe/London` | Specify a timezone to use EG Europe/London. |
| `-v /config` | this will store config on the docker host |

## User / Group Identifiers

When using volumes (`-v` flags) permissions issues can arise between the host OS and the container, we avoid this issue by allowing you to specify the user `PUID` and group `PGID`.

Ensure any volume directories on the host are owned by the same user you specify and any permissions issues will vanish like magic.

In this instance `PUID=1000` and `PGID=1000`, to find yours use `id user` as below:

```
  $ id username
    uid=1000(dockeruser) gid=1000(dockergroup) groups=1000(dockergroup)
```


&nbsp;
## Application Setup

Edit sample config file `config/nntp2nntp.conf` with upstream provider details and rename the local users.

New user passwords can be created by running the password hash generator
```
docker exec -it nntp2nntp /usr/bin/nntp2nntp.py pass
```
entering the desired password and copying the resulting string to the relevant user line in `/config/nntp2nntp.conf`

Example with a user called `Dave` and with a password of `password`
```
Dave    = 5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8
```



## Support Info

* Shell access whilst the container is running: `docker exec -it nntp2nntp /bin/bash`
* To monitor the logs of the container in realtime: `docker logs -f nntp2nntp`
* container version number 
  * `docker inspect -f '{{ index .Config.Labels "build_version" }}' nntp2nntp`
* image version number
  * `docker inspect -f '{{ index .Config.Labels "build_version" }}' linuxserver/nntp2nntp`

## Updating Info

Most of our images are static, versioned, and require an image update and container recreation to update the app inside. With some exceptions (ie. nextcloud, plex), we do not recommend or support updating apps inside the container. Please consult the [Application Setup](#application-setup) section above to see if it is recommended for the image.  
  
Below are the instructions for updating containers:  
  
### Via Docker Run/Create
* Update the image: `docker pull linuxserver/nntp2nntp`
* Stop the running container: `docker stop nntp2nntp`
* Delete the container: `docker rm nntp2nntp`
* Recreate a new container with the same docker create parameters as instructed above (if mapped correctly to a host folder, your `/config` folder and settings will be preserved)
* Start the new container: `docker start nntp2nntp`
* You can also remove the old dangling images: `docker image prune`

### Via Docker Compose
* Update all images: `docker-compose pull`
  * or update a single image: `docker-compose pull nntp2nntp`
* Let compose update all containers as necessary: `docker-compose up -d`
  * or update a single container: `docker-compose up -d nntp2nntp`
* You can also remove the old dangling images: `docker image prune`

### Via Watchtower auto-updater (especially useful if you don't remember the original parameters)
* Pull the latest image at its tag and replace it with the same env variables in one run:
  ```
  docker run --rm \
  -v /var/run/docker.sock:/var/run/docker.sock \
  containrrr/watchtower \
  --run-once nntp2nntp
  ```
* You can also remove the old dangling images: `docker image prune`

## Building locally

If you want to make local modifications to these images for development purposes or just to customize the logic: 
```
git clone https://github.com/linuxserver/docker-nntp2nntp.git
cd docker-nntp2nntp
docker build \
  --no-cache \
  --pull \
  -t linuxserver/nntp2nntp:latest .
```

The ARM variants can be built on x86_64 hardware using `multiarch/qemu-user-static`
```
docker run --rm --privileged multiarch/qemu-user-static:register --reset
```

Once registered you can define the dockerfile to use with `-f Dockerfile.aarch64`.

## Versions

* **28.06.19:** - Rebasing to alpine 3.10.
* **23.04.19:** - Multiarch builds and build from Github fork.
* **15.05.18:** - Initial Release.
