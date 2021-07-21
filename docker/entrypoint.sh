#!/bin/bash
set -e

case $1 in
    start)
        service php8.0-fpm start
        supervisord -n -c /var/www/html/docker/supervisord.conf
    ;;
esac

exec "$@"