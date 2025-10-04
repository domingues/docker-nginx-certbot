#!/bin/sh

while :; do
    inotifywait -r --exclude ".*(swp|swx|lock|~)$" -e create -e modify -e delete -e move \
        /etc/nginx/conf.d/* \
        /etc/nginx/ssl/*
    nginx -t
    if [ $? -eq 0 ]
    then
        echo "Detected NGINX Configuration Change"
        echo "Executing: nginx -s reload"
        sleep 0.1
        nginx -s reload
    fi
    sleep 1
done &
