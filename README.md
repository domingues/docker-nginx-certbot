# Docker NGINX Certbot

Simple Compose with NGINX server and SSL certificates auto renewed with Certbot.

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

Optionaly set a custom Certbot `cli.ini` on `compose.yml`.

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
