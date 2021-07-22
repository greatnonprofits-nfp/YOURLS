#!/bin/bash
set -e

case $1 in
    start)
        /etc/init.d/php8.0-fpm start
        sed -i "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/" /etc/php/8.0/fpm/php.ini
        sed -e 's/;daemonize = yes/daemonize = no/' -i /etc/php/8.0/fpm/php-fpm.conf
        sed -i -e "s/;clear_env = no/clear_env = no/g" /etc/php/8.0/fpm/pool.d/www.conf
        sed -i -e "s/;pm.max_children = 5/pm.max_children = 500/g" /etc/php/8.0/fpm/pool.d/www.conf
        sed -i -e "s/;pm.max_requests = 500/pm.max_requests = 2000/g" /etc/php/8.0/fpm/pool.d/www.conf
        sed -i -e "s/;pm.max_spare_servers = 3/pm.max_requests = 25/g" /etc/php/8.0/fpm/pool.d/www.conf
        /etc/init.d/php8.0-fpm restart
        supervisord -n -c /var/www/html/docker/supervisord.conf
    ;;
esac

exec "$@"