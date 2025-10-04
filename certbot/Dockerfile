FROM python:3.12-slim

RUN apt-get update && apt-get install -y \
    inotify-tools \
    && rm -rf /var/lib/apt/lists/*

RUN pip install \
	certbot~=2.11.0 \
	certbot-dns-cloudflare~=2.11.0

COPY docker-entrypoint.sh /docker-entrypoint.sh

COPY cli.ini /root/.config/letsencrypt/cli.ini
COPY certs.list /etc/letsencrypt/certs.list

ENTRYPOINT ["/docker-entrypoint.sh"]
