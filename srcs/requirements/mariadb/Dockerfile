# syntax=docker/dockerfile:1

FROM	debian:buster
WORKDIR	/

# Installs the mariadb server and client
RUN	apt-get update
RUN	apt-get install -y mariadb-server mariadb-client expect
RUN	rm -rf /var/lib/apt/lists/*

# Sets up the /var/lib/mysqls folder so it can definitely be written to
RUN	mkdir -p /var/run/mysqld
RUN	chown -R mysql:mysql /var/run/mysqld
RUN	chmod 777 /var/run/mysqld

COPY	./conf/mysqld.conf /etc/mysql/my.cnf

COPY	./tools/mariadb.sh /usr/local/bin/
COPY	./conf/wordpress.sql /usr/local/bin/
RUN	chmod +x /usr/local/bin/mariadb.sh
RUN	chmod +x /usr/local/bin/wordpress.sql

EXPOSE	3306

ENTRYPOINT [ "/usr/local/bin/mariadb.sh" ]

CMD	["mysqld", "--bind-address=0.0.0.0"]
