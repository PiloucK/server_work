server {
        listen                  [::]:80 default_server;

        server_name             _;
        return                  301 https://$host$request_uri;
}

server {
        listen                  [::]:443 ssl;

        ssl_certificate         ssl/localhost.cert;
        ssl_certificate_key	ssl/localhost.key;

        root                    /var/www/html;
        index                   index.php index index.html index.htm accueil.html;

        server_name             _;

        location / {
            autoindex       on;
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
	        fastcgi_pass unix:/var/run/php/php7.3-fpm.sock;
	}
}
