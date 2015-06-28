FROM        nginx:latest

MAINTAINER  tdeheurles@gmail.com

COPY        index.html   /www/
COPY        nginx.conf  /etc/nginx/

EXPOSE      __SERVICEPORT__

CMD         nginx
