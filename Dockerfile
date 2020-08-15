FROM	debian:buster

RUN     apt-get update && \
		apt-get upgrade -y && \
		apt-get install -y \
			curl \
			default-mysql-server \
			nginx \
			openssl \
			phpmyadmin \
            php-fpm \
			php-mysql \
			wget

COPY	srcs/nginx-config /etc/nginx/sites-available/localhost

# Nginx config
RUN		mkdir /var/www/localhost

# Wordpress
RUN		wget https://www.wordpress.org/latest.tar.gz && tar xzvf latest.tar.gz -C /var/www/

# Setting 'safe' phpmyadmin (no root access and randomly named path)
RUN		ln -s /usr/share/phpmyadmin /var/www/html/phpmyadmin && \
		mv /var/www/html/phpmyadmin /var/www/html/thisisnothere
COPY	srcs/phpmyadmin/pma_pass etc/nginx/pma_pass

# Using let's encrypt for tls protocol but doubts on subject limits so ssl set up (add git to apt-get install to use tls)
# RUN		git clone https://github.com/letsencrypt/letsencrypt /opt/letsencrypt --depth=1 && \
# 		/opt/letsencrypt/letsencrypt-auto certonly --rsa-key-size 4096 --standalone -d www.isicca.com
RUN		mkdir /etc/ssl && \
		openssl req -nodes -newkey rsa:2048 -keyout /etc/ssl/certifssl.key -out /etc/ssl/certifssl.csr && \
		openssl x509 -req -in /etc/ssl/certifssl.csr -signkey /etc/ssl/certifssl.key -out /etc/ssl/certifssl.crt -days 999
