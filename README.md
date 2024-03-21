# Inception
A 42 project to learn Docker by setting up and connecting three containers, one each for MariaDB, Wordpress and NGINX


# Instructions
'make' will call 'docker compose up --build' to build and start the containers. 'make down' will call 'docker compose down' to take down the containers

To access the Wordpress site you need to add '127.0.0.1 bzawko.42.fr' to /etc/hosts, then go to https://bzawko.42.fr while the container is running on your machine.
You can log in as the admin on the worpress site by going to 'https://bzawko.42.fr/wp-login.php' and logging in with the MYSQL_USER and MYSQL_PASSWORD values set in the .env file.
