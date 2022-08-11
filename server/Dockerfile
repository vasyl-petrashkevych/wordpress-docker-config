FROM php:8.0-apache

RUN a2enmod rewrite

RUN docker-php-ext-install mysqli pdo pdo_mysql && docker-php-ext-enable pdo_mysql; \
    apt-get update && apt-get upgrade -y; \
    apt-get install wget \
    unzip

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2

EXPOSE 80
WORKDIR /var/www/

RUN usermod -u 1000 www-data; \
    chmod 755 /var/www/

# Install Composer
#RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

#Install wp-cli
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar; \
    chmod +x wp-cli.phar; \
    mv wp-cli.phar /usr/local/bin/wp;

# Clean up
RUN apt-get clean \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#RUN wp core download --path="/var/www/" --allow-root --force  && wp core verify-checksums --allow-root
RUN chown -R www-data:www-data /var/www
