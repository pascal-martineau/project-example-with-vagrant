#!/bin/sh

msg_task "Install Mail system"

    msg_subtask "Install ruby and rubygems"
        apt-get -y install rubygems ruby ruby-dev
        apt-get -y install libsqlite3-dev

    msg_subtask "Install Mailcatcher"
        gem install mailcatcher

    msg_subtask "Setup Mailcatcher to run on startup"
        sed -i "s/^exit 0$/\/usr\/local\/bin\/mailcatcher/g" /etc/rc.local
        echo exit 0 >> /etc/rc.local

    msg_subtask "Install reverse proxy to access webmail"
        cp -Rf ${FILES_DIR}/etc/apache2/sites-available/mailcatcher /etc/apache2/sites-available/
        a2enmod proxy
        a2enmod proxy_http
        a2ensite mailcatcher
        service apache2 restart

    msg_subtask "Install and configure postfix to relay all mail to mailcatcher"
        cat ${FILES_DIR}/preseed/postfix.preseed | debconf-set-selections
        apt-get -y install postfix
        service postfix restart

    msg_subtask "Start Mailcatcher"
        mailcatcher

block_hint "Now, you can send emails to [ smtp://localhost:1025 ] and read them on [ http://localhost:8025 ]"

