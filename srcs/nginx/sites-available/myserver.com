server {
        listen  [::]:80 default_server;

        return 301 https://$host$request_uri;
}

server {
        server_name localhost www.localhost www.localhost.com;
        listen  [::]:443 ssl;

        access_log /var/log/nginx/website/access.log;
        error_log /var/log/nginx/website/error.log warn;

        ssl     on;
	ssl_certificate         /ssl/localhost.cert;
	ssl_certificate_key     /ssl/localhost.key;

        root    /var/www/localhost;
        index   index.php;

        location / {
                autoindex on;
                try_files $uri $uri/ =404;
        }

        location ~* wp-config.php {
                deny all;
        }

        location / {
        	try_files $uri $uri/ /index.php?$args;
	}

        location /thisisnothere {
                auth_basic "Admin Login";
                auth_basic_user_file /etc/nginx/pma_pass;
        }
}
