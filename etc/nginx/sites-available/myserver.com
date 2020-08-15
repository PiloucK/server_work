server {
        listen  [::]:80 default_server;

        return 301 https://$host$request_uri;
}

server {
        server_name localhost www.localhost www.localhost.com;
        listen  [::]:443 ssl;

        ssl_protocols TLSv1.2;
        ssl_certificate /etc/letsencrypt/live/www.localhost.com/fullchain.pem;
        ssl_certificate_key /etc/letsencrypt/live/www.localhost.com/privkey.pem;

        root /var/www/html;
        index index.php index.html index.htm;

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
