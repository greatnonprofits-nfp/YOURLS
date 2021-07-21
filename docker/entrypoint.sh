#!/bin/bash
set -e

case $1 in
    start)
        supervisord -n -c /var/www/html/docker/supervisord.conf
    ;;
esac

exec "$@"