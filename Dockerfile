FROM	debian:buster-slim

RUN     apt-get update \
		&& apt-get upgrade -y \
		&& apt-get install -y \
			default-mysql-server \
			htop \
			nginx \
			openssl \
			php \
			php-cli php-curl php-fpm php-gd php-intl php-mbstring php-mysql \	
			wget

# Nginx config
COPY	srcs/myserv_index_on.conf .
COPY	srcs/myserv_index_off.conf .
COPY	srcs/switch_index.sh .
RUN		cp myserv_index_on.conf /etc/nginx/sites-enabled/myserv.conf \
		&& rm -rf /etc/nginx/sites-enabled/default

RUN     service mysql start ; \
		mysql -u root -e "CREATE DATABASE "wordpress" ;" ; \ 
		mysql -u root -e "CREATE USER 'betterme'@'localhost' IDENTIFIED BY 'password'" ; \
		mysql -u root -e "GRANT ALL PRIVILEGES ON *.* TO 'betterme'@'localhost'"; \
		mysql -u root -e "FLUSH PRIVILEGES";

# SSL certificate generation
RUN openssl req -new -newkey rsa:2048 -nodes -x509 -subj '/C=FR/ST=IDF/L=PARIS/O=YourOrg/CN=www.yourorg.com' -days 3650 -keyout example.key -out example.crt \
	&& mv example.crt /etc/ \
	&& mv example.key /etc/

# Wordpress download
RUN		wget -O /var/www/html/wp.tar.gz https://wordpress.org/latest.tar.gz \
		&& tar xzf /var/www/html/wp.tar.gz --directory /var/www/html\
		&& rm -f /var/www/html/wp.tar.gz /var/www/html/wordpress/wp-config-sample.php
COPY	srcs/wp-config.php /var/www/html/wordpress
RUN     chown -R www-data:www-data /var/www/html/wordpress/ \
		&& chmod -R 755 /var/www/html/wordpress

# Downloat and set 'safe' phpmyadmin (no root access and randomly named path)
RUN		mkdir /var/www/html/pma \
		&& wget https://www.phpmyadmin.net/downloads/phpMyAdmin-latest-english.tar.gz \
		&& tar xzf phpMyAdmin-latest-english.tar.gz --directory /var/www/html/pma \
		&& mv /var/www/html/pma/* /var/www/html/thisisnothere \
		&& rm -rf /var/www/html/pma
COPY	srcs/pma_pass /etc/nginx/pma_pass

CMD		service mysql restart ; \
        service php7.3-fpm start ; \
        service nginx start ; \
		sleep infinity
