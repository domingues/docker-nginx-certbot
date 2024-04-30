FROM nginx:1.25

RUN apt-get update && apt-get install -y \
    inotify-tools \
    openssl \
    && rm -rf /var/lib/apt/lists/*

COPY 99-autoreload.sh /docker-entrypoint.d/

RUN mkdir -p /etc/nginx/ssl/ && \
    openssl req -x509 -nodes -days 3650 -newkey rsa:2048 \
    -subj "/CN=example.com" \
    -keyout /etc/nginx/ssl/selfsigned.key --out /etc/nginx/ssl/selfsigned.crt

COPY default.conf /etc/nginx/conf.d/
