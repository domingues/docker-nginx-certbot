#!/bin/bash

cleanup () {
    kill -s SIGTERM $!
    exit 0
}

trap cleanup SIGINT SIGTERM

while [ 1 ]
do
    inotifywait -e create -e modify /etc/letsencrypt/certs.list
    if [ $? -eq 0 ]
    then
        echo "Detected certs.list change"
        sleep 0.1
        while IFS= read -r line; do
            if [[ -n "$line" && ! "$line" =~ ^\s*# ]]; then
                certname="${line%% *}"
                domains="${line#* }"
                command="certbot certonly -n --cert-name \"$certname\" -d \"$domains\""
                echo "Executing: $command"
                eval $command
            fi
        done < /etc/letsencrypt/certs.list
    fi
    sleep 1
done &

while [ 1 ]
do
    command="certbot renew"
    echo "Executing: $command"
    eval $command
    sleep 43200 &
    wait $!
done
