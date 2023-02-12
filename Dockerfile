ARG PHP_VERSION=8
ARG REPO=ghcr.io/templeandwebster/
FROM ${REPO:-}php:${PHP_VERSION}-cli-alpine

WORKDIR /app/
COPY --from=composer /usr/bin/composer /usr/bin/composer
COPY composer.json /app/
RUN docker-php-ext-enable pcov \
    && COMPOSER_ALLOW_SUPERUSER=1 composer config --no-plugins allow-plugins.dealerdirect/phpcodesniffer-composer-installer true \
    && composer require -W --no-interaction --sort-packages -oa --apcu-autoloader --prefer-stable \
    dealerdirect/phpcodesniffer-composer-installer \
    mockery/mockery \
    moxio/php-codesniffer-sniffs \
    pcov/clobber \
    phpcompatibility/php-compatibility \
    phpunit/phpunit \
    slevomat/coding-standard  \
    squizlabs/php_codesniffer

ENV PATH=$PATH:/app/vendor/bin
WORKDIR /code/