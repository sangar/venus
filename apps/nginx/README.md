Site configs are loaded from `~/.config/venus/nginx/sites-enabled/*.conf`. Create the folder before starting, otherwise Docker creates it owned by root:
```sh
mkdir -p ~/.config/venus/nginx/sites-enabled
```

Run without ssl config first and create certificates
```sh
docker compose run --rm  certbot certonly --webroot --webroot-path /var/www/certbot/ -d example.org
```

More info at:
* [Nginx as a server](https://mindsers.blog/en/post/https-using-nginx-certbot-docker/)
* [Nginx and Let’s Encrypt with Docker in Less Than 5 Minutes](https://pentacent.medium.com/nginx-and-lets-encrypt-with-docker-in-less-than-5-minutes-b4b8a60d3a71)
