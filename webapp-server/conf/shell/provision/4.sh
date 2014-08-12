#!/bin/sh



msg_task "Install and configure PHP"

    msg_subtask "Install PHP"
        apt-get -y install php5

    msg_subtask "Install phpunit php5-intl php5-gd php5-xdebug"
        apt-get -y install phpunit php5-intl php5-gd php5-xdebug

    msg_subtask "Install php5-mysql"
        apt-get -y install php5-mysql

    msg_subtask "Change PHP CLI configuration"
        sed -i "s/^;date\.timezone =$/date.timezone = 'UTC'/g" /etc/php5/cli/php.ini
        echo "xdebug.max_nesting_level = 250" >> /etc/php5/cli/conf.d/xdebug.ini




msg_task "Install and configure PHP for Apache2"

    msg_subtask "Configure PHP for Apache2"
        sed -i "s/^;date\.timezone =$/date.timezone = 'UTC'/g" /etc/php5/apache2/php.ini
        echo "xdebug.max_nesting_level = 250" >> /etc/php5/apache2/conf.d/*xdebug.ini

    msg_subtask "Enable mod php5 on Apache2"
        a2enmod php5

    msg_subtask "Restart Apache2"
        service apache2 restart




msg_task "Install and configure PHP for Nginx"

    msg_subtask "Install PHP FPM"
        apt-get -y install php5-fpm

    msg_subtask "Configure PHP FPM"
        sed -i "s/^;date\.timezone =$/date.timezone = 'UTC'/g" /etc/php5/fpm/php.ini
        sed -i "s/^user =.*$/user = vagrant/g" /etc/php5/fpm/pool.d/www.conf
        sed -i "s/^group =.*$/group = vagrant/g" /etc/php5/fpm/pool.d/www.conf
        sed -i "s/^listen\.owner =.*$/listen.owner = vagrant/g" /etc/php5/fpm/pool.d/www.conf
        sed -i "s/^listen\.group =.*$/listen.group = vagrant/g" /etc/php5/fpm/pool.d/www.conf
        sed -i "s/^;listen\.mode = .*$/listen.mode = 0660/g" /etc/php5/fpm/pool.d/www.conf
        echo "xdebug.max_nesting_level = 250" >> /etc/php5/fpm/conf.d/*xdebug.ini

    msg_subtask "Restart PHP FPM"
        service php5-fpm restart

