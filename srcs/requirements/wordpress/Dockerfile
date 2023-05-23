# syntax=docker/dockerfile:1

FROM	debian:buster
WORKDIR	/

# Installs the things required to install and run wordpress
RUN	apt-get update
RUN	apt-get install -y wget php php-cgi php-mysql php-fpm
RUN	rm -rf /var/lib/apt/lists/*

# Installs the wordpress CommandLineInterface
RUN	wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN	chmod +x wp-cli.phar
RUN	mv wp-cli.phar /usr/local/bin/wp

# Copies the www.conf file to where it belongs
COPY ./conf/www.conf /etc/php/7.3/fpm/pool.d/

RUN	mkdir /run/php

COPY	./tools/create_wordpress.sh /usr/local/bin/
RUN	chmod +x /usr/local/bin/create_wordpress.sh
ENTRYPOINT	["/usr/local/bin/create_wordpress.sh"]

WORKDIR	/var/www/html

EXPOSE	9000

CMD	["/usr/sbin/php-fpm7.3", "-F"]
