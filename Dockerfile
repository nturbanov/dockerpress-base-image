FROM php:7.4.16-fpm

LABEL maintainer="Evermade"

# install the PHP extensions we need
# from wordpress:5.1-php7.2-fpm
RUN set -ex; \
    \
    apt-get update; \
    apt-get install -y --no-install-recommends \
        libjpeg-dev \
        libpng-dev \
        libfreetype6-dev \
        libzip-dev \
        libwebp-dev \
        nginx \
        libnginx-mod-http-headers-more-filter \
        supervisor \
        gnupg \
        nano \
        wget \
        zip \
        mariadb-client \
        cron \
        sudo \
        # Install certbot
        certbot \
        python-certbot-nginx \
    ; \
    \
    docker-php-ext-configure gd --with-freetype --with-jpeg --with-webp; \
    docker-php-ext-install gd mysqli opcache zip; \
    \
    rm -rf /var/lib/apt/lists/*; \
    \
    # Install WP-CLI
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar; \
    chmod +x wp-cli.phar; \
    mv wp-cli.phar /usr/local/bin/wp
