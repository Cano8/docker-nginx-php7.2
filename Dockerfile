FROM ubuntu:xenial
MAINTAINER NJ Darda <jedrekdarda@gmail.com>

RUN apt-get update && apt-get -y install software-properties-common python-software-properties
RUN apt-get clean && apt-get update && apt-get install -y locales
RUN locale-gen en_US.UTF-8 && export LANG=en_US.UTF-8 && export LC_ALL=en_US.UTF-8 && add-apt-repository -y ppa:ondrej/php
RUN apt-get update

# Install base packages
RUN DEBIAN_FRONTEND=noninteractive apt-get -y upgrade

# Install apache, php and utils
RUN DEBIAN_FRONTEND=noninteractive apt-get -yq install --no-install-recommends apt-utils \
        curl \
        wget \
        nginx \
        tree \
        git \
        vim \
        zip \
        make \
        unzip \
        lnav \
        inotify-tools \
        colordiff \
        htop \
        php-pear \
        libmcrypt-dev \
        php7.2 \
        php7.2-apcu \
        php7.2-bcmath \
        php7.2-bz2 \
        php7.2-cli \
        php7.2-common \
        php7.2-curl \
        php7.2-dba \
        php7.2-dev \
        php7.2-fpm \
        php7.2-fpm \
        php7.2-gd \
        php7.2-json \
        php7.2-mbstring \
        php7.2-memcache \
        php7.2-mysql \
        php7.2-mysql \
        php7.2-mysqli \
        php7.2-pgsql \
        php7.2-redis \
        php7.2-soap \
        php7.2-xdebug \
        php7.2-xml \
        php7.2-zip

#RUN rm -rf /var/lib/apt/lists/*

RUN printf "\n" | pecl install mcrypt-1.0.1

# Add image configuration and scripts
ADD run.sh /run.sh
RUN chmod 755 /*.sh

EXPOSE 80
WORKDIR /share/
RUN chown www-data:www-data /var/www -R

CMD ["/run.sh"]
