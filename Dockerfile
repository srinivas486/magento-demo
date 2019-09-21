FROM ubuntu:16.04

ENV DEBIAN_FRONTEND noninteractive

ADD ./docker_payload/magento2.conf /etc/apache2/sites-available/
# Copy PHP configuration
ADD ./docker_payload/php.ini /etc/php/7.2/apache2/conf.d
ADD ./docker_payload/Magento-CE-2.3.2-2019-06-13-03-23-52.tar.gz /magento2

RUN adduser --disabled-password --gecos "" magento && \
    adduser magento www-data && \
    apt-get -yq update && \
    apt-get install apache2 -y && \
    a2enmod rewrite expires && \
    a2dissite 000-default.conf && \
    a2ensite magento2.conf && \
    apt install software-properties-common -y && \
    LC_ALL=C.UTF-8 add-apt-repository -y ppa:ondrej/php5-compat && \
    LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php -y && \
    apt-get -yq update && \
    apt install php7.2 php7.2-curl php7.2-mysql libapache2-mod-php7.2 \
                php7.2-bcmath php7.2-curl php7.2-gd php7.2-intl php7.2-mbstring \
                php7.2-soap php7.2-xml php7.2-xsl php7.2-zip php7.2-json php7.2-iconv mysql-client curl -y && \
    curl -sS https://getcomposer.org/installer | php --install-dir=/usr/local/bin --filename=composer && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

ADD ./docker_payload/runner.sh /
VOLUME /var/www/html/magento2
WORKDIR /var/www/html/magento2
EXPOSE 80 443
CMD ["/runner.sh"]
