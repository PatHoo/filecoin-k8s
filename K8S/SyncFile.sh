#!/bin/bash

hosts_file=$1

IP=$(cat ${hosts_file}|grep -Ev "^#|^$"|awk -F"[ ]+" '{gsub(/^\s+|\s+$/, ""); print $1}')

for i in $IP
do
  echo $i
  scp  ./kube1.17.2.tar.gz  root@$i:~
done

