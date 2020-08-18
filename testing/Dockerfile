FROM debian:buster
 
MAINTAINER fcoudert <fcoudert@student.42.fr>

RUN apt-get update && apt-get install -y nginx ; \
		apt-get install -y wget ; \
		apt-get install -y default-mysql-server ; \
		apt-get install -y php-fpm php-mysql php-cli php-curl php-gd php-intl php-mbstring ; \
		apt-get install -y php

RUN		mkdir /var/www/html/pma \
		&& wget https://www.phpmyadmin.net/downloads/phpMyAdmin-latest-english.tar.gz \
		&& tar xzf phpMyAdmin-latest-english.tar.gz --directory /var/www/html/pma \
		&& mv /var/www/html/pma/* /var/www/html/thisisnothere \
		&& mkdir /var/www/html/thisisnothere/tmp \
		&& rm -rf /var/www/html/pma
COPY	srcs/pma_pass /etc/nginx/pma_pass

RUN service mysql start ; \
		mysql -u root -e "CREATE DATABASE "wordpress" ;" ; \ 
		mysql -u root -e "CREATE USER 'betteruser'@'localhost' IDENTIFIED BY 'password'" ; \
		mysql -u root -e "GRANT ALL PRIVILEGES ON *.* TO 'betteruser'@'localhost'"; \
		mysql -u root -e "FLUSH PRIVILEGES";

RUN		wget https://wordpress.org/latest.tar.gz \
		&& tar xzf latest.tar.gz --directory /var/www/html\
		&& rm -f latest.tar.gz /var/www/html/wordpress/wp-config-sample.php
COPY	srcs/wp-config.php /var/www/html/wordpress

RUN chown -R www-data:www-data /var/www/html/wordpress/ ; \
		chmod -R 755 /var/www/html/wordpress

RUN	    openssl genrsa -out /etc/example.key 2048 \
		&& openssl req -new -x509 -key /etc/example.key -out /etc/example.crt \
			-days 3650 -subj /CN=www.localhost

COPY	srcs/my_site.conf /etc/nginx/sites-enabled
RUN		rm -rf /etc/nginx/sites-enabled/default /var/www/html/index.nginx-debian.html
COPY 	srcs/accueil.html /var/www/html


CMD service mysql start ; \
	service php7.3-fpm start ; \
	service nginx start ; \
	sleep infinity
