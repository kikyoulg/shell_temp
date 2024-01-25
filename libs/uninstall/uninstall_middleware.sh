#!/bin/bash

uninstall_middleware() {
    cd $pwd
    ./helm uninstall kafka -n$fedx_ns
    ./helm uninstall clickhouse-cluster -n$fedx_ns
    ./helm uninstall redis -n$fedx_ns
}