FROM php:8.0.30-fpm-bullseye

LABEL maintainer="Evermade"

# install the PHP extensions we need (https://make.wordpress.org/hosting/handbook/server-environment/#php-extensions)
RUN set -ex; \
	\
	# Nginx apt dependencies
	apt-get update; \
	apt-get install -y --no-install-recommends \
		apt-transport-https \
		lsb-release \
	; \
	\
	# This adds a more frequently updated nginx apt repository
	curl -sSLo /usr/share/keyrings/deb.sury.org-nginx.gpg https://packages.sury.org/nginx/apt.gpg; \
	echo "deb [signed-by=/usr/share/keyrings/deb.sury.org-nginx.gpg] https://packages.sury.org/nginx/ $( lsb_release -sc ) main" > /etc/apt/sources.list.d/nginx.list; \
	apt-get update; \
	\
	# Upgrade apt packages
	apt-get upgrade -y; \
	\
	# Install new apt packages
	apt-get install -y --no-install-recommends \
		\
		# PHP GD extension dependencies
		libfreetype6-dev \
		libjpeg-dev \
		libpng-dev \
		libwebp-dev \
		libzip-dev \
		\
		# PHP Intl extension dependencies
		libicu-dev \
		\
		# PHP ImageMagick extension dependencies
		libmagickwand-dev \
		\
		# PDF preview rendering for WordPress
		ghostscript \
		\
		# Nginx
		nginx \
		libnginx-mod-http-headers-more-filter \
		\
		# Tools
		cron \
		gnupg \
		less \
		mariadb-client \
		nano \
		sudo \
		supervisor \
		wget \
		zip \
		\
		# Logging utils
		expect \
		logrotate \
		moreutils \
		rsyslog \
		\
		# Install certbot
		certbot \
		python3-certbot-nginx \
	; \
	\
	# Configure PHP GD extension
	docker-php-ext-configure gd \
		--with-freetype \
		--with-jpeg \
		--with-webp \
	; \
	\
	# Compile and install PHP extensions
	docker-php-ext-install -j "$( nproc )" \
		gd \
		intl \
		mysqli \
		opcache \
		zip \
	; \
	\
	# Install PHP ImageMagick extension
	pecl install imagick-3.7.0; \
	docker-php-ext-enable imagick; \
	\
	# Cleanup
	rm -rf /tmp/pear /var/lib/apt/lists/*; \
	\
	# Install WP-CLI
	curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar; \
	chmod +x wp-cli.phar; \
	mv wp-cli.phar /usr/local/bin/wp; \
	\
	# Install WP-CLI tab completions
	curl -O https://raw.githubusercontent.com/wp-cli/wp-cli/master/utils/wp-completion.bash; \
	mv wp-completion.bash /etc/wp-completion.bash; \
	echo 'source /etc/wp-completion.bash' >> /etc/bash.bashrc
