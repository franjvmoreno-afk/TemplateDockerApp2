# Usa la imagen base de Alpine
FROM alpine:latest

# Variables de entorno
ENV SERVER_NAME=moodle.asir
ENV SERVER_PORT=80

# Exponer el puerto estándar de Apache
EXPOSE 80

# Instalar Apache + PHP
RUN apk update && \
    apk add --no-cache \
    apache2 \
    php82 \
    php82-apache2 \
    php82-mysqli \
    php82-pdo_mysql \
    php82-json \
    php82-curl \
    php82-xml \
    php82-phar \
    php82-opcache \
    php82-gd \
    php82-mbstring \
    php82-zip \
    php82-fileinfo \
    php82-openssl \
    php82-apcu \
    php82-intl \
    php82-bcmath \
    php82-exif \
    php82-soap \
    php82-sodium \
    php82-ctype \
    php82-dom \
    && rm -rf /var/lib/apk/lists/*


# Crear DocumentRoot
RUN mkdir -p /var/www/${SERVER_NAME} \
    && chown -R apache:apache /var/www/${SERVER_NAME} \
    && chmod -R 755 /var/www/${SERVER_NAME}

# Copiar Moodle
COPY ./src/ /var/www/${SERVER_NAME}/
RUN chown -R apache:apache /var/www/${SERVER_NAME}

# Copiar configuración del VirtualHost (sin variables)
COPY ./docker/http/apache+php/conf.d/000-moodle.local.conf /etc/apache2/conf.d/

# Iniciar Apache en foreground
ENTRYPOINT ["httpd", "-D", "FOREGROUND"]
