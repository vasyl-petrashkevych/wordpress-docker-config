FROM php:7.4-apache

RUN a2enmod rewrite

# For ssl certificate
RUN a2enmod ssl && a2enmod socache_shmcb

RUN docker-php-ext-install mysqli pdo pdo_mysql && docker-php-ext-enable pdo_mysql; \
    apt-get update && apt-get upgrade -y; \
    apt-get install wget \
    unzip

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2

EXPOSE 80
WORKDIR /var/www/html

RUN usermod -u 1000 www-data; \
    chmod 755 /var/www/html

# Clean up
RUN apt-get clean \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

