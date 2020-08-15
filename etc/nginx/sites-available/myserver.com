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

        root    /var/www/localhost/wordpress;
        index   index.html;

        location / {
                autoindex on;
                try_files $uri $uri/ =404;
        }

        location /thisisnothere {
                auth_basic "Admin Login";
                auth_basic_user_file /etc/nginx/pma_pass;
        }
}
