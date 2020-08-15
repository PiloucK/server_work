server {
        listen  [::]:80 default_server;

        return 301 https://$host$request_uri;
}

server {
        listen  [::]:443 ssl;

        root /var/www/html;
        index index.php index.html index.htm;
        server_name localhost www.localhost;

        location / {
                autoindex on;
                try_files $uri $uri/ =404;
        }

        location /thisisnothere {
                auth_basic "Admin Login";
                auth_basic_user_file /etc/nginx/pma_pass;
        }

        location ~ \.php$ {
                include snippets/fastcgi-php.conf;
                fastcgi_pass unix:/var/run/php/php7.2-fpm.sock;
        }

        location ~ /\.ht {
                deny all;
        }
}
