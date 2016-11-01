#!/bin/sh

apk update && apk add inotify-tools
nginx -g 'daemon on;'
echo "Nginx running"

dit_to_watch=/sites
while inotifywait -qqre modify,attrib,close_write,move,create,delete "$dit_to_watch"; do
    echo "Sites updated! Reloading..."
    nginx -s reload
done
