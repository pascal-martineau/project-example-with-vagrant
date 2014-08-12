#!/bin/sh


msg_task "Prepare env for web servers"

    msg_subtask "Set correct ownership and permissions"
        chown -R vagrant:vagrant /var/www
        chmod -R 777 /var/www



msg_task "Install or update symfony"

    msg_subtask "Install composer"
        curl -sS https://getcomposer.org/installer | php
        sudo mv composer.phar /usr/local/bin/composer

    msg_subtask "Make a composer install to refresh"
        TMP_OLD_DIR=`pwd`
        cd /home/vagrant/src
        composer install
        cd ${TMP_OLD_DIR}


block_hint "To finish the installation, do a first 'Upload to vagrant' in PHPStorm."
