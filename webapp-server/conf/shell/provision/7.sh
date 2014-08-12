#!/bin/sh

msg_task "Init app stuff"

    msg_subtask "Init database"
        TMP_OLD_DIR=`pwd`
        cd /home/vagrant/src
        sudo -u vagrant php app/console doctrine:database:create
        sudo -u vagrant php app/console doctrine:migration:migrate
        cd ${TMP_OLD_DIR}

