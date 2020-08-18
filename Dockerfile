FROM	debian:buster

RUN     apt-get update && \
		apt-get upgrade -y && \
		apt-get install -y \
			default-mysql-server \
			nginx \
			openssl \
			php \
			php-cli \
			php-fpm \
			php-mysql \
			php-mbstring php-zip php-gd \
			wget

COPY	srcs/wordpress.sql .
COPY	srcs/start.sh .

# Nginx config
COPY	srcs/myserver.com /etc/nginx/sites-available/localhost
RUN		rm -rf /etc/nginx/sites-enabled/* && \
		rm -rf /usr/share/nginx/www && \
		ln -s /etc/nginx/sites-available/localhost /etc/nginx/sites-enabled

# Using let's encrypt for tls protocol but doubts on subject limits so ssl set up (add git to apt-get install to use tls)
# RUN		git clone https://github.com/letsencrypt/letsencrypt /opt/letsencrypt --depth=1 && \
# 		/opt/letsencrypt/letsencrypt-auto certonly --rsa-key-size 4096 --standalone -d www.isicca.com

# SSL certificate generation
RUN		mkdir -p /ssl && \
		openssl genrsa -out /ssl/localhost.key 2048 && \
		openssl req -new -x509 -key /ssl/localhost.key -out /ssl/localhost.cert \
			-days 3650 -subj /CN=www.localhost

# Wordpress download
RUN		mkdir -p /var/www/localhost && \
		wget -O /var/www/localhost/wp.tar.gz https://wordpress.org/latest.tar.gz && \
		tar xzf /var/www/localhost/wp.tar.gz && \
		mv wordpress /var/www/localhost/wordpress && \
		rm -f /var/www/localhost/wp.tar.gz
COPY	srcs/wp-config.php /var/www/localhost/wordpress

# RUN		wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
# 		chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp

# Downloat and set 'safe' phpmyadmin (no root access and randomly named path)
RUN		mkdir /var/www/localhost/pma && \
		wget https://www.phpmyadmin.net/downloads/phpMyAdmin-latest-english.tar.gz && \
		tar xzf phpMyAdmin-latest-english.tar.gz --directory /var/www/localhost/pma && \
			mv /var/www/localhost/pma/* /var/www/localhost/thisisnothere && \
		rm -rf /var/www/localhost/pma
# COPY	srcs/pma_secure.php /etc/phpmyadmin/conf.d
COPY	srcs/config.inc.php /var/www/localhost/thisisnothere


RUN		service mysql start && \
		cat wordpress.sql | mysql -u root && \
		rm wordpress.sql

EXPOSE	80 443

CMD		bash start.sh
