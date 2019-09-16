FROM ubuntu:16.04

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get -yq update
#RUN apt-get upgrade -q -y -u  -o \
#   Dpkg::Options::="--force-confdef" --allow-downgrades \
#   --allow-remove-essential --allow-change-held-packages \
#   --allow-change-held-packages --allow-unauthenticated;

RUN apt-get install -yq software-properties-common python-software-properties 
RUN LC_ALL=C.UTF-8 add-apt-repository -y ppa:ondrej/php
RUN apt-get update && apt-get install -yq \
    # Install git
    git \
    # Install apache server \
    apache2 \
    # Install php 7.2
    libapache2-mod-php7.2 \
    php7.2-cli \
    php7.2-json \
    php7.2-curl \
    php7.2-bcmath \
    php-bcmath \
    php7.2-fpm \
    php7.2-gd \
    php7.2-ldap \
    php7.2-mbstring \
    php7.2-mysql \
    php7.2-soap \
    php7.2-sqlite3 \
    php7.2-xml \
    php7.2-zip \
    php7.2-intl \
    # Install tools
#    iputils-ping \
#    apt-utils \
    locales \
    curl \
    mysql-client \
    mysql* \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# ======= composer =======
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Set locales
RUN locale-gen en_US.UTF-8

RUN a2enmod rewrite expires

VOLUME /var/www/html/magento2
# Copy Magento packages
ADD ./docker_payload/Magento-CE-2.3.2-2019-06-13-03-23-52.tar.gz /var/magento2

RUN rm etc/apache2/sites-enabled/000-default.conf
# Copy Magento Config to Apache sites
ADD ./docker_payload/magento2.conf /etc/apache2/sites-enabled/

# Copy PHP configuration
ADD ./docker_payload/php.ini /etc/php/7.2/apache2/conf.d

EXPOSE 80 443


WORKDIR /var/magento2
RUN find var generated vendor pub/static pub/media app/etc -type f -exec chmod g+w {} +
RUN find var generated vendor pub/static pub/media app/etc -type d -exec chmod g+ws {} +
RUN chown -R :www-data .

RUN chmod u+x bin/magento
RUN chmod -R a+w+r var
RUN chmod -R a+w+r app

ADD ./docker_payload/runner.sh /var/
RUN chmod +x /var/runner.sh

WORKDIR /var/www/html/magento2

CMD ["/var/runner.sh"]
