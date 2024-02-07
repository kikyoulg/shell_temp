#!/bin/bash

sql_dir = $pwd/config/$env/sql/
mysql_pod = mysql-0

init_sql(){
  kubectl cp ${sql_dir}/${party_id}.sql mysql-0:/tmp/ -n${fedx_ns}
  kubectl -n${fedx_ns} exec -it ${mysql_pod} -- bash -c "mysql -u root -pWa@123456 < /tmp/${party_id}.sql"
}


