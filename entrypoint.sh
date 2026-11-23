#!/bin/sh

(
    while true; do
        /scripts/build_repo.sh
        sleep 3600
    done
) &

exec nginx -e /dev/stderr -g 'daemon off;'
