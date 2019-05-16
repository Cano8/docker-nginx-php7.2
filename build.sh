#!/bin/bash

# setup users
groupadd -g 1000 docker_user
useradd -r -u 1000 -g 1000 docker_user
mkhomedir_helper docker_user
echo -e "p\np" | passwd docker_user

usermod -aG sudo docker_user
usermod -a -G 1000 www-data
usermod -a -G www-data docker_user
ln -sf /home/docker_user/.bashrc /root/.bashrc

# setup log permissions
chmod 666 /var/log/nginx/*

# install psysh
composer g require psy/psysh:@stable
