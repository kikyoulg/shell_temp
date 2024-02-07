#!/bin/bash

import_sql() {
    kubectl apply -f tools/mysql-temp.yaml

    echo "等待mysql启动" && sleep 5

    kubectl wait -l name=mysql --for=condition=ready pod --timeout=99s

    kubectl cp fedx mysql:/tmp

    kubectl exec -it mysql -- bash -c "mysql -uroot -pWa@123456 -h172.20.8.55 -P32565 </tmp/fedx/ddl.sql"
    kubectl exec -it mysql -- bash -c "mysql -uroot -pWa@123456 -h172.20.8.55 -P32565 </tmp/fedx/dml.sql"
    kubectl exec -it mysql -- bash -c "mysql -uroot -pWa@123456 -h172.20.8.55 -P32565 </tmp/fedx/dml2.sql"

    kubectl delete -f tools/mysql-temp.yaml
}
