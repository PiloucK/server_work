FROM	debian:buster

RUN     apt-get update && \
		apt-get upgrade -y && \
		apt-get install -y \
			default-mysql-server \
			git \
			nginx \
			openssl \
			phpmyadmin \
            php-fpm \
			php-mysql \
			wget

# Setting 'safe' phpmyadmin (no root access and randomly named path)
RUN		ln -s /usr/share/phpmyadmin /var/www/html/phpmyadmin && \
		mv /var/www/html/phpmyadmin /var/www/html/thisisnothere
COPY	srcs/phpmyadmin/pma_pass etc/nginx/pma_pass

# Using let's encrypt
RUN		git clone https://github.com/letsencrypt/letsencrypt /opt/letsencrypt --depth=1 && \
		/opt/letsencrypt/letsencrypt-auto certonly --rsa-key-size 4096 --standalone -d www.isicca.com

RUN		mkdir /var/www/localhost
