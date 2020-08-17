service nginx start
service mysql restart
service php-fpm start
nginx -g "daemon off;"
tail -f /dev/null
