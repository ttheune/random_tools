#!/bin/bash

logstash='<your ES endpoint here>'

list=$(curl -s "$logstash/_cat/indices" | grep logstash | awk '{print $3}' | sort -n)
set -- $list
clean="curl -XDELETE $logstash/$1/"

percent=$(curl -scurl -s $logstash/_cat/allocation?v | grep -v ' 1 <' | grep -v shards | awk '{print $5}' | sort -rn)
set -- $percent
if [ $1 -gt 85 ]
then eval $clean
fi
