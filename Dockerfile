FROM	debian:buster

RUN     apt-get update \
		&& apt-get upgrade -y \
		&& apt-get install -y \
			default-mysql-server \
			nginx \
			openssl \
			php \
			php-cli php-fpm php-gd php-mbstring php-mysql php-zip \
			wget

# COPY	srcs/wordpress.sql .
# COPY	srcs/start.sh .

# Nginx config
COPY	srcs/myserv.conf /etc/nginx/sites-enabled
RUN		rm -rf /etc/nginx/sites-enabled/default /var/www/html/index.nginx-debian.html
		# && ln -s /etc/nginx/sites-available/localhost /etc/nginx/sites-enabled

COPY    srcs/accueil.html /var/www/html

RUN     service mysql start ; \
		mysql -u root -e "CREATE DATABASE "wordpress" ;" ; \ 
		mysql -u root -e "CREATE USER 'betterme'@'localhost' IDENTIFIED BY 'password'" ; \
		mysql -u root -e "GRANT ALL PRIVILEGES ON *.* TO 'betterme'@'localhost'"; \
		mysql -u root -e "FLUSH PRIVILEGES";

# SSL certificate generation
RUN	    mkdir -p /ssl \
		&& openssl genrsa -out /ssl/localhost.key 2048 \
		&& openssl req -new -x509 -key /ssl/localhost.key -out /ssl/localhost.cert \
			-days 3650 -subj /CN=www.localhost

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
# COPY	srcs/pma_secure.php /etc/phpmyadmin/conf.d
# COPY	srcs/config.inc.php /var/www/html/thisisnothere

# RUN		service mysql start \
# 		&& cat wordpress.sql | mysql -u root \
# 		&& rm wordpress.sql

CMD		service mysql restart ; \
        service php7.3-fpm start ; \
        service nginx start ; \
        sleep infinity
