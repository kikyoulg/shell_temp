#!/bin/bash

sql_dir = $pwd/config/$env/sql

# 替换sql中的master节点ip
update_sql(){
  
  for i in ls ${sql_dir}
  do
    sed -i s/172.20.60.46/${master_ip}/g
  done
}


