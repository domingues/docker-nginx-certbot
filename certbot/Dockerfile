FROM certbot/certbot:v2.10.0

RUN apk --no-cache add inotify-tools

COPY docker-entrypoint.sh /docker-entrypoint.sh

COPY cli.ini /root/.config/letsencrypt/cli.ini
COPY certs.list /etc/letsencrypt/certs.list

ENTRYPOINT ["/docker-entrypoint.sh"]
