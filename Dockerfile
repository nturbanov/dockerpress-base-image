FROM php:7.2-fpm

LABEL maintainer="Evermade"

# install the PHP extensions we need
# from wordpress:4.9-php7.2-fpm
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
    ; \
    \
    docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr; \
    docker-php-ext-install gd mysqli zip;
