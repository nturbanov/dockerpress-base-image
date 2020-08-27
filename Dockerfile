FROM php:7.4.6-fpm

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
        nginx \
        supervisor \
        gnupg \
        subversion \
        git \
    ; \
    \
    docker-php-ext-configure gd --with-freetype --with-jpeg; \
    docker-php-ext-install gd mysqli zip; \
    \
    rm -rf /var/lib/apt/lists/*
