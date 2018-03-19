#!/bin/bash

fsPath="/share/fs/"
stashPath="/share/stash/"

for file in $(find /share/fs/ -type f);
    do
        target=${file:9};
        echo Linking: ${file};
        echo      To: ${target};
        ln -sf ${file} ${target};
    done

# install composer
curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer

# install psysh
wget https://git.io/psysh && chmod +x psysh && mv psysh /usr/local/bin/psysh

service nginx start
service php7.2-fpm start

if [ -f ${stashPath}run.sh ];
then
    echo 'RUNNING CUSTOM SCRIPT'
    . ${stashPath}run.sh
fi

tail -f /dev/null
