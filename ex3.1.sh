#!/bin/bash

# modificare pentru ex 5 - Dorneanu Diana

#  $1 - Nume de host (domeniu)
#  $2 - Adresa IP
#  $3 - Server DNS pentru interogare

validateip() {
    local hostname=$1
    local ip=$2
    local dns_server=$3

    if [[ -z "$hostname" || -z "$ip" || -z "$dns_server" ]]; then
        echo "Usage: validateip <hostname> <ip> <dns_server>"
        return 1
    fi

   
    resolved_ip=$(dig +short @$dns_server $hostname | grep -w "$ip")

    if [[ -z "$resolved_ip" ]]; then
        return 1 
    else
        return 0
    fi
}


dns_server="8.8.8.8"


cat /etc/hosts | while read -r line
do
    
    if [[ -z "$line" || "$line" =~ ^# ]]; then
        continue
    fi

    
    ip=$(echo "$line" | awk '{print $1}')
    domeniu=$(echo "$line" | awk '{print $2}')

   
    if ! validateip "$domeniu" "$ip" "$dns_server"; then
        echo "Bogus IP for $domeniu in /etc/hosts!"
    fi
done
