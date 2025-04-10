# Use PHP 8.1 with Alpine
FROM php:8.1-fpm-alpine

# Change Alpine mirror to a faster/reliable one
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/' /etc/apk/repositories

# Install system dependencies
RUN apk add --no-cache \
    libzip-dev \
    zip \
    unzip \
    nodejs \
    npm \
    git \
    && docker-php-ext-install pdo_mysql \
    && docker-php-ext-install zip \
    && docker-php-ext-install bcmath \
    && docker-php-ext-install pcntl

# Copy PHP-FPM config
ADD devops/docker/www.conf /usr/local/etc/php-fpm.d/www.conf

# Set working directory and permissions
RUN mkdir -p /var/www/html && chown www-data:www-data /var/www/html
WORKDIR /var/www/html

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
