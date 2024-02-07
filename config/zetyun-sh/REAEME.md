服务更新：
    110环境更新：
        cd /home/fedx/fedx-install && git pull && helm upgrade bsd bsd -f config/zetyun-sh/bsd/1000.yaml -nbsd-1000
        cd /home/fedx/fedx-install && git pull && helm upgrade fedx fedx/ -f config/zetyun-sh/fedx/1000.yaml -nfedx-1000
        cd /home/fedx/fedx-install && git pull && helm upgrade fedx-custom fedx-custom/ -f config/zetyun-sh/fedx-custom/1000.yaml -nfedx-custom-1000

    55环境更新：
        cd /home/fedx/fedx-install && git pull && helm upgrade bsd bsd -f config/zetyun-dev/bsd/1000.yaml -nbsd-1000
        cd /home/fedx/fedx-install && git pull && helm upgrade fedx fedx/ -f config/zetyun-dev/fedx/1000.yaml -nfedx-1000
        cd /home/fedx/fedx-install && git pull && helm upgrade fedx-custom fedx-custom/ -f config/zetyun-dev/fedx-custom/1000.yaml -nfedx-custom-1000        

清理原有mysql/ck:
    kubectl scale --replicas=0 deployment/mysql -nfate-1000
    kubectl scale --replicas=0 sts/mysql -nbsd-1000
    kubectl scale --replicas=0 sts/mysql -nfedx-1000
    kubectl scale --replicas=0 sts/mysql -nfedx-custom-1000
    kubectl scale --replicas=0 sts/clickhouse-cluster-s0-r0 -nbsd-1000
    kubectl scale --replicas=0 sts/zk-clickhouse-cluster -nbsd-1000
    
双活clickhouse部署：
    cd /home/fedx/fedx-install && ./helm install clickhouse-cluster tools/clickhouse -f config/zetyun-sh/middleware/clickhouse.yaml -nsh

双活hdfs地址：
    55：32203
    110：31510

