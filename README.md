# Docker NGINX Certbot

Simple Compose with NGINX server and SSL certificates auto-renewed with Certbot.

## Usage

Clone this repository:
```bash
git clone https://github.com/domingues/docker-nginx-certbot.git
cd docker-nginx-certbot
```

Make configuration skeleton:
```bash
mkdir config
cp certbot/certs.list config/certbot-certs.list
cp nginx/default.conf config/nginx-default.conf
```

Optionally set a custom Certbot `cli.ini` on `compose.yml`.

Build and run the containers:
```bash
docker compose up --build
```

Specify the list of certificates on `./config/certbot-certs.list`, Certbot will run on file change.

Configure the NGINX server on `./config/nginx-default.conf`, it will reload on configuration change.

Certificate locations:

|             | Certbot                                           | NGINX                                           |
| ----------- | ------------------------------------------------- | ----------------------------------------------- |
| Certificate | `/etc/letsencrypt/live/[certname]/fullchain.pem` | `/etc/nginx/ssl/live/[certname]/fullchain.pem` |
| Key         | `/etc/letsencrypt/live/[certname]/privkey.pem`   | `/etc/nginx/ssl/live/[certname]/privkey.pem`   |

## Advanced Usage - dns-01 challenge

Using [`certbot-dns-cloudflare`](https://certbot-dns-cloudflare.readthedocs.io/) as an example.

Change Certbot `cli.ini` (`config/certbot-cli.ini`) configuration:
```diff bash
# Uncomment to use the webroot authenticator. Replace webroot-path with the
# path to the public_html / webroot folder being served by your web server.
-authenticator = webroot
-webroot-path = /var/www/certbot/
+# authenticator = webroot
+# webroot-path = /var/www/certbot/

# Uncomment to use the dns-cloudflare authenticator.
-# authenticator = dns-cloudflare
-# dns-cloudflare-credentials = /root/.config/letsencrypt/cloudflare.ini
+authenticator = dns-cloudflare
+dns-cloudflare-credentials = /root/.config/letsencrypt/cloudflare.ini
```

Update volumes on `compose.yml`:
```diff
    volumes:
      - acme-challenge:/var/www/certbot:rw
      - certs:/etc/letsencrypt:rw
      - ./config/certbot-certs.list:/etc/letsencrypt/certs.list:ro
-      # - ./config/certbot-cli.ini:/root/.config/letsencrypt/cli.ini:ro
-      # - ./config/certbot-cloudflare.ini:/root/.config/letsencrypt/cloudflare.ini:ro
+      - ./config/certbot-cli.ini:/root/.config/letsencrypt/cli.ini:ro
+      - ./config/certbot-cloudflare.ini:/root/.config/letsencrypt/cloudflare.ini:ro
```
