FROM ubuntu:focal

RUN apt-get update \
    && apt install software-properties-common -qyy --fix-missing -o APT::Install-Recommends=false -o APT::Install-Suggests=false \ 
    && add-apt-repository ppa:ondrej/php

RUN apt-get update \
    && apt-get install -qyy --fix-missing -o APT::Install-Recommends=false -o APT::Install-Suggests=false \
        git \
        libssl-dev \
        nginx \
        openssl \
        php8.0 \
        php8.0-fpm \
        php8.0-mysql \
        default-mysql-client \
        supervisor \
        nano \
    && apt-get clean

RUN service supervisor restart

WORKDIR /var/www/html

COPY . /var/www/html

COPY docker/config-docker.php user/config.php

RUN sed -i "/worker_processes\s/c\worker_processes auto;" /etc/nginx/nginx.conf
RUN sed -i "/worker_connections\s/c\    worker_connections 245760;\n    use epoll;\n    multi_accept on;" /etc/nginx/nginx.conf
RUN echo "worker_rlimit_nofile 300000;" >> /etc/nginx/nginx.conf
RUN echo "daemon off;" >> /etc/nginx/nginx.conf

RUN rm -f /etc/nginx/sites-enabled/default

RUN mv /var/www/html/docker/nginx /var/www/html/docker/nginx.conf
RUN mv /var/www/html/docker/supervisord /var/www/html/docker/supervisord.conf

RUN mv /var/www/html/docker/htaccess /var/www/html/.htaccess

RUN ln -sf /var/www/html/docker/nginx.conf /etc/nginx/sites-enabled/

RUN chown -R www-data:www-data /var/www/html

COPY docker/entrypoint.sh /
RUN chmod +x /entrypoint.sh

RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*[~]$

EXPOSE 80

ENTRYPOINT ["/entrypoint.sh"]

CMD ["start"]