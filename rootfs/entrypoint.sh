#!/bin/sh
set -e 

shares=${MOUNTS:-"/data"}

if [[ ! -f /.configured ]]; then
    echo "reverse lookup = false" >> /etc/rsyncd.conf    
    echo ${shares}|tr ',' '\n' | while read mount ; do
        if [[ -d ${mount} ]]; then 
            name=$(echo ${mount}|tr '/' '_')
            { \
            	echo "[${name}]"; \
                echo "  path = ${mount}"; \
                echo "  comment = Mount - ${mount}"; \
            } >> /etc/rsyncd.conf
        fi
    done
    touch /.configured
fi

exec "$@"