#!/bin/bash

pod_list = `kubectl -n${namespace} describe pod|grep Image:|awk '{print $2}'|sort|uniq`
# IFS=$'\n' read -rd '' -a pod_array <<< "$pod_list"

save_images(){
  for i in ${pod_list}
  do
    sudo docker pull $i
  done

  sudo docker save ${pod_array[@]|pigz -9 > /tmp/${2}.tgz

  echo "调用成功"
}
