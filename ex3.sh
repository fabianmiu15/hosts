#!/bin/bash

cat /etc/hosts | while read -r line
do
	if [[ -z "$line" || "$line" =~ ^# ]]; then
		continue
	fi
	ip=$(echo "$line" | awk '{print $1}')
	domeniu=$(echo "$line" | awk '{print $2}')
	ip2=$(nslookup "$domeniu" | grep "Address" | tail -n 1 | awk '{print $2}')
	if [[ "$ip" != "$ip2" ]]; then
		echo "Bogus IP for $domeniu in /etc/hosts!"
	fi
done

