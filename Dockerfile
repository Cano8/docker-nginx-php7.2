FROM ubuntu:xenial
MAINTAINER NJ Darda <jedrekdarda@gmail.com>

RUN apt-get update && apt-get -y install software-properties-common python-software-properties
RUN apt-get clean && apt-get update && apt-get install -y locales
RUN locale-gen en_US.UTF-8 && export LANG=en_US.UTF-8 && export LC_ALL=en_US.UTF-8 && add-apt-repository -y ppa:ondrej/php
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get -y upgrade

RUN DEBIAN_FRONTEND=noninteractive apt-get -yq install --no-install-recommends apt-utils \
    curl \
    git \
    libmcrypt-dev \
    make \
    mysql-client \
    unzip \
    wget \
    zip
RUN DEBIAN_FRONTEND=noninteractive apt-get -yq install \
    php-pear \
    php7.2 \
    php7.2-apcu \
    php7.2-bcmath \
    php7.2-bz2 \
    php7.2-cli \
    php7.2-common \
    php7.2-curl \
    php7.2-dba \
    php7.2-dev \
    php7.2-gd \
    php7.2-json \
    php7.2-mbstring \
    php7.2-memcache \
    php7.2-mysql \
    php7.2-redis \
    php7.2-soap \
    php7.2-xdebug \
    php7.2-xml \
    php7.2-zip
RUN DEBIAN_FRONTEND=noninteractive apt-get -yq install \
    colordiff \
    htop \
    inotify-tools \
    lnav \
    nginx \
    php7.2-fpm \
    php7.2-pgsql \
    tree \
    vim
RUN printf "\n" | pecl install mcrypt-1.0.1
RUN rm -rf /var/lib/apt/lists/*
RUN curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer

ADD run.sh /run.sh
ADD build.sh /build.sh
RUN chmod 755 /run.sh /build.sh
RUN /build.sh
RUN chown www-data:www-data /var/www -R
WORKDIR /project/

CMD ["/run.sh"]
