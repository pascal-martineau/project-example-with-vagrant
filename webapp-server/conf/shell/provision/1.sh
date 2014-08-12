#!/bin/sh

msg_task "Set dotdeb repositories"

    msg_subtask "Add dotdeb packages to sources.list"
        echo "deb http://packages.dotdeb.org wheezy-php55 all" >> /etc/apt/sources.list
        echo "deb-src http://packages.dotdeb.org wheezy-php55 all" >> /etc/apt/sources.list

    msg_subtask "Get dotdeb key and add it"
        wget http://www.dotdeb.org/dotdeb.gpg
        apt-key add dotdeb.gpg && rm dotdeb.gpg

    msg_subtask "Update APT repositories"
        apt-get update



msg_task "Common packages and configuration"

    msg_subtask "Configure SSH to speed up login"
        echo "UseDNS no" >> /etc/ssh/sshd_config

    msg_subtask "Install customized prompt"
        apt-get -y install figlet
        figlet -t ${APP_NAME} -w 150 > /etc/motd

    msg_subtask "Install lynx, curl"
        apt-get -y install lynx curl

    msg_subtask "Install customized dotfiles to /home/vagrant"
        cp -Rf ${FILES_DIR}/home/vagrant/* /home/vagrant/

    msg_subtask "Install debconf-utils"
        apt-get -y install debconf-utils



msg_task "Prepare env for web servers"

    msg_subtask "Create the /var/www directory"
        mkdir /var/www
    msg_subtask "Set correct ownership and permissions"
        chown -R vagrant:vagrant /var/www
        chmod -R 777 /var/www

