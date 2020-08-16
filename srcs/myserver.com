server {
        listen                  [::]:80 default_server;

        server_name             _;
        return                  301 https://$host$request_uri;
}

server {
        server_name             localhost www.localhost;
        listen                  [::]:443 ssl;

        ssl                     on;
	ssl_certificate         /ssl/localhost.cert;
	ssl_certificate_key     /ssl/localhost.key;

        root                    /var/www/localhost/wordpress;
        index                   index.php;

        location / {
                autoindex       on
        	try_files       $uri $uri/ =404;
	}

        location ~* wp-config.php {
                deny all;
        }

        location /thisisnothere {
                auth_basic "Admin Login";
                auth_basic_user_file /etc/nginx/pma_pass;
        }

        location ~ \.php$ {
	        include snippets/fastcgi-php.conf;
	        fastcgi_pass unix:/run/php/php7.3-fpm.sock;
	}
}
