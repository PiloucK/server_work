FROM	debian:buster

RUN     apt-get update && \
		apt-get upgrade -y && \
		apt-get install -y \
			default-mysql-server \
			nginx \
			openssl \
			php-mysql \
			wget

COPY	srcs/wordpress.sql .
COPY	srcs/start.sh .

# Nginx config
RUN		mkdir /var/www/localhost && \
		rm -rf /etc/nginx/sites-enabled/* && \
		ln -s /etc/nginx/sites-available/localhost /etc/nginx/sites-enabled && \
		rm -rf /usr/share/nginx/www
COPY	srcs/myserver.com /etc/nginx/sites-available/localhost

# Using let's encrypt for tls protocol but doubts on subject limits so ssl set up (add git to apt-get install to use tls)
# RUN		git clone https://github.com/letsencrypt/letsencrypt /opt/letsencrypt --depth=1 && \
# 		/opt/letsencrypt/letsencrypt-auto certonly --rsa-key-size 4096 --standalone -d www.isicca.com

# SSL certificate generation
RUN		mkdir -p /etc/ssl && \
		openssl genrsa -out /etc/ssl/localhost.key 2048 && \
		openssl req -new -x509 -key /etc/ssl/localhost.key -out /etc/ssl/localhost.cert \
			-days 3650 -subj /CN=www.localhost

# Wordpress download
RUN		wget -O /var/www/localhost/wp.tar.gz https://wordpress.org/latest.tar.gz && \
		tar xzf /var/www/localhost/wp.tar.gz && \
		mv wordpress /var/www/localhost/wordpress && \
		rm -f /var/www/localhost/wp.tar.gz
COPY	srcs/wp-config.php /var/www/localhost/wordpress

# Downloat and set 'safe' phpmyadmin (no root access and randomly named path)
RUN		mkdir /var/www/localhost/pma && \
		mkdir /var/www/localhost/tmp && \
		wget -O /var/www/localhost/pma/nothing.tar.gz https://www.phpmyadmin.net/downloads/phpMyAdmin-latest-english.tar.gz && \
		tar xzf /var/www/localhost/pma/nothing.tar.gz --directory /var/www/localhost/tmp && \
		mv /var/www/localhost/tmp/* /var/www/html/thisisnothere && \
		rm -rf /var/www/localhost/pma
COPY	srcs/pma_pass etc/nginx/pma_pass

RUN		service mysql start && \
		cat wordpress.sql | mysql -u root && \
		rm wordpress.sql

CMD		bash start.sh
