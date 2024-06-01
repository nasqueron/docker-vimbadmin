#
# Nasqueron - ViMbAdmin
#

FROM nasqueron/nginx-php-fpm:novolume
MAINTAINER Nasqueron Organisation <docker@nasqueron.org>

#
# Prepare the container
#

COPY files /

WORKDIR /var/wwwroot/default

RUN apt update && \
    apt install -y libpq-dev && \
    docker-php-ext-install pgsql && \ 
    docker-php-ext-install pdo_pgsql && \
    printf "\n" | pecl install memcache && \
    git clone https://github.com/opensolutions/ViMbAdmin.git . && \
    composer install --prefer-dist --no-dev -o && \
    chown -R app:app /var/wwwroot/default && \
    rm -r /var/lib/apt/lists/*

