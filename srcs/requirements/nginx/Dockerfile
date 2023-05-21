# syntax=docker/dockerfile:1

FROM	debian:buster
WORKDIR	/

# Installs NGINX and OpenSSL
RUN	apt-get update
RUN	apt-get install -y nginx openssl

# Creates the SSL key and certificate
RUN	mkdir /etc/nginx/ssl
RUN	openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes \
	-out /etc/nginx/ssl/bzawko.crt -keyout /etc/nginx/ssl/bzawko.key \
	-subj "/C=AU/ST=South Australia/L=Adelaide/O=42/CN=bzawko/"

# Moves the conf file to the correct directory on the Docker container
COPY	./conf/nginx.conf /etc/nginx/conf.d

# Create the folder for NGINX runtime configuration files
RUN	mkdir -p /run/nginx

# Allows you to enable port 443
EXPOSE	443

# Command to start NGINX on the Docker container
CMD ["nginx", "-g", "daemon off;"]
