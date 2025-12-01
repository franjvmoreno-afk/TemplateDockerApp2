# Usa la imagen base de Alpine
FROM alpine:latest

ARG SERVER_NAME=${SERVERNAME}
ARG SERVER_PORT=${SERVERPORT}
ENV SERVER_NAME=${SERVER_NAME}
ENV SERVER_PORT=${SERVER_PORT}

EXPOSE ${SERVER_PORT}

# Instalar Apache 2, su módulo PHP y las extensiones de Moodle
RUN apk update && \
    apk add --no-cache \
    apache2 \
    apache2-mod-php82 \
    php8 \
    php8-mysqli \
    php8-pdo_mysql \
    php8-json \
    php8-curl \
    php8-xml \
    php8-phar \
    php8-opcache \
    php8-gd \
    php8-mbstring \
    php8-zip \
    php8-fileinfo \
    php8-openssl \
    php8-apcu \
    php8-intl \
    php8-bcmath \
    php8-exif \
    php8-soap \
    php8-sodium \
    php8-ctype \
    php8-dom \
    rm -rf /var/lib/apk/lists/*