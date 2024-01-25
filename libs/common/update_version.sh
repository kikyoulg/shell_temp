#!/bin/bash

tag=v1.2.0

update_version() {
    array=(fedx-1000 fedx-1100 fedx-2000)
    for i in "${array[@]}"; do
        kubectl -n$i set image deployment/fedx-api fedx-api=registry.zet-fl.com/fedx/release/fedx-api:${tag}
        kubectl -n$i set image deployment/fedx-helper fedx-helper=registry.zet-fl.com/fedx/release/fedx-helper:${tag}
        kubectl -n$i set image deployment/fedx-job-api fedx-job-api=registry.zet-fl.com/fedx/release/fedx-job-api:${tag}
        kubectl -n$i set image deployment/fedx-job-worker fedx-job-worker=registry.zet-fl.com/fedx/release/fedx-job-worker:${tag}
        kubectl -n$i set image deployment/fedx-web fedx-web=registry.zet-fl.com/fedx/release/fedx-web:${tag}
        kubectl -n$i set image deployment/fedx-postman fedx-postman=registry.zet-fl.com/fedx/release/fedx-postman:${tag}
    done
}
