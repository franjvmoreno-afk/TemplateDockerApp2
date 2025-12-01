# Usa la imagen base de Alpine
FROM alpine:latest

ARG SERVER_NAME=${SERVERNAME}
ARG SERVER_PORT=${SERVERPORT}
ENV SERVER_NAME=${SERVER_NAME}
ENV SERVER_PORT=${SERVER_PORT}

# Exponer el puerto para el contenedor (8081 en tu caso)
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
    && rm -rf /var/lib/apk/lists/*

EXPOSE ${SERVER_PORT}


# 1. Crear el DocumentRoot y configurar permisos para el usuario 'apache'
RUN mkdir -p /var/www/${SERVER_NAME} \
    && chown -R apache:apache /var/www/${SERVER_NAME} \
    && chmod -R 755 /var/www/${SERVER_NAME}

# 2. Copiar los archivos de la aplicación Moodle al DocumentRoot
COPY ./src/ /var/www/${SERVER_NAME}/

# 3. Reafirmar que el usuario 'apache' es dueño de los archivos copiados
RUN chown -R apache:apache /var/www/${SERVER_NAME}

# 4. Copiar la configuración del VirtualHost
COPY ./docker/http/apache+php/conf.d/000-moodle.local.conf /etc/apache2/conf.d/

# El ENTRYPOINT que inicia Apache en foreground
ENTRYPOINT [ "httpd", "-D", "FOREGROUND"]