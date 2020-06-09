FROM php:7.2-fpm

LABEL maintainer="Evermade"

# install the PHP extensions we need
# from wordpress:5.1-php7.2-fpm
RUN set -ex; \
    \
    apt-get update; \
    apt-get install -y --no-install-recommends \
        libjpeg-dev \
        libpng-dev \
        nginx \
        supervisor \
        gnupg \
        subversion \
        git \
        nano \        
        wget \
        zip \
        mysql-client \
    ; \
    \
    docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr; \
    docker-php-ext-install gd mysqli zip; \
    \
    rm -rf /var/lib/apt/lists/*
