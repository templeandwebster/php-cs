ARG PHP_VERSION=8
ARG REPO=ghcr.io/templeandwebster/
FROM ${REPO:-}php:${PHP_VERSION}-cli-alpine

WORKDIR /app/
COPY --from=composer /usr/bin/composer /usr/bin/composer
COPY composer.json /app/
RUN docker-php-ext-enable pcov && composer install --no-interaction --no-progress --optimize-autoloader

ENV PATH=$PATH:/app/vendor/bin
WORKDIR /code/