service nginx start
service mysql restart
nginx -g "daemon off;"
tail -f /dev/null
