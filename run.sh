#!/bin/bash

# link files
fsPath="/project/.environment/docker/fs/"
# stashPath="/project/stash/"

for file in $(find /project/.environment/docker/fs/ -type f);
    do
        target=${file:31};
        echo Linking: ${file};
        echo      To: ${target};
        ln -sf ${file} ${target};
    done

service nginx start
service php7.4-fpm start

# if [ -f ${stashPath}run.sh ];
# then
#     echo 'RUNNING CUSTOM SCRIPT'
#     . ${stashPath}run.sh
# fi

tail -f /dev/null
