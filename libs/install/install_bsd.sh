#!/bin/bash

install_bsd() {
    cd $pwd && chmod +x helm && ./helm install clickhouse-cluster tools/clickhouse -f config/$env/middleware/clickhouse.yaml -n$bsd_ns
    cd $pwd && chmod +x helm && ./helm install redis tools/redis/redis -n$bsd_ns
    cd $pwd && chmod +x helm && ./helm install bsd bsd -f config/$env/bsd/$party_id.yaml -n$bsd_ns --create-namespace
    for i in $(seq 1 50); do
        if [[ "$(kubectl get pods -n$bsd_ns -o jsonpath='{.items[*].status.containerStatuses[0].ready}' | xargs -n1 | uniq)" != "true" ]]; then
            echo -e "\033[41;37m $bsd_ns 服务安装中 \033[0m"
            sleep 10
        else
            echo -e "\033[42;37m $bsd_ns 服务安装完成 \033[0m" && return 2
        fi
    done
    [[ $? -ne 2 ]] && echo -e "\033[41;37m $bsd_ns 服务安装失败 \033[0m" && exit
}

after_create_pod() {
    #kafka topic
    kubectl -n$bsd_ns exec -it kafka-0 -- kafka-topics.sh --create --topic fedx-api --bootstrap-server 127.0.0.1:9092 --config max.message.bytes=12800000 --config flush.messages=1 --partitions 1 --replication-factor 1

    kubectl -n$bsd_ns exec -it kafka-0 -- kafka-topics.sh --create --topic postman-topic --bootstrap-server 127.0.0.1:9092 --config max.message.bytes=12800000 --config flush.messages=1 --partitions 1 --replication-factor 1

    kubectl -n$bsd_ns exec -it kafka-0 -- kafka-topics.sh --create --topic fedx_system_log --bootstrap-server 127.0.0.1:9092 --config max.message.bytes=12800000 --config flush.messages=1 --partitions 1 --replication-factor 1

    #init ck sql
    kubectl cp $pwd/fedx/clickhouse_ddl.sql clickhouse-cluster-s0-r0-0:/tmp -n$bsd_ns
    kubectl -n$bsd_ns exec -it clickhouse-cluster-s0-r0-0 -- bash -c "clickhouse-client --user default --password ck@12345 --multiquery <  /tmp/clickhouse_ddl.sql"
}
