#!/bin/sh

# Switch nginx index set up when needed using bash inside container

TARGET_LOCATION="/etc/nginx/sites-enabled"

if cmp -s "myserv_index_on.conf" "/etc/nginx/sites-enabled/myserv.conf"; then
    \cp myserv_index_off.conf /etc/nginx/sites-enabled/myserv.conf
    echo "Auto index off"
else
    \cp myserv_index_on.conf /etc/nginx/sites-enabled/myserv.conf
    echo "Auto index on"
fi

service nginx restart
