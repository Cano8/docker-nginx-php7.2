FROM ubuntu:xenial
LABEL maintainer="jedrekdarda@gmail.com"

RUN apt-get update && apt-get -y install software-properties-common python-software-properties
RUN apt-get clean && apt-get update && apt-get install -y locales
RUN locale-gen en_US.UTF-8 && export LANG=en_US.UTF-8 && export LC_ALL=en_US.UTF-8 && add-apt-repository -y ppa:ondrej/php
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get -y upgrade

RUN DEBIAN_FRONTEND=noninteractive apt-get -yq install --no-install-recommends apt-utils \
    curl \
    git \
    make \
    mysql-client \
    unzip \
    wget \
    zip
RUN DEBIAN_FRONTEND=noninteractive apt-get -yq install \
    php7.4 \
    php7.4-apcu \
    php7.4-bcmath \
    php7.4-bz2 \
    php7.4-cli \
    php7.4-common \
    php7.4-curl \
    php7.4-dba \
    php7.4-dev \
    php7.4-gd \
    php7.4-json \
    php7.4-mbstring \
    php7.4-memcache \
    php7.4-mysql \
    php7.4-redis \
    php7.4-soap \
    php7.4-xdebug \
    php7.4-xml \
    php7.4-zip
RUN DEBIAN_FRONTEND=noninteractive apt-get -yq install \
    colordiff \
    bash-completion \
    htop \
    inotify-tools \
    lnav \
    nginx \
    php7.4-fpm \
    php7.4-pgsql \
    tree \
    vim
RUN rm -rf /var/lib/apt/lists/*
RUN curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer

ADD run.sh /run.sh
ADD build.sh /build.sh
RUN chmod 755 /run.sh /build.sh
RUN /build.sh
RUN chown www-data:www-data /var/www -R
WORKDIR /project/

CMD ["/run.sh"]
