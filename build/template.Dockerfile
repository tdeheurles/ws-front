# From => https://github.com/GoogleCloudPlatform/nginx-ssl-proxy/blob/master/Dockerfile
FROM        nginx:latest

MAINTAINER  tdeheurles@gmail.com

RUN         rm /etc/nginx/conf.d/*.conf

WORKDIR     /usr/src

COPY        index.html    /www/
COPY        start.sh      /usr/src/
COPY        nginx.conf    /etc/nginx/
COPY        site*.conf    /usr/src/

ENTRYPOINT  ./start.sh
