FROM ubuntu/nginx:1.26-24.10_edge

RUN rm /etc/nginx/sites-enabled/default

RUN apt-get update && apt-get install -y \
    libnginx-mod-http-brotli-filter \
    inotify-tools \
    openssl \
    && rm -rf /var/lib/apt/lists/*

COPY 99-autoreload.sh /docker-entrypoint.d/

RUN mkdir -p /etc/nginx/ssl/ && \
    openssl req -x509 -nodes -days 3650 -newkey rsa:2048 \
    -subj "/CN=example.com" \
    -keyout /etc/nginx/ssl/selfsigned.key --out /etc/nginx/ssl/selfsigned.crt

COPY default.conf /etc/nginx/conf.d/
