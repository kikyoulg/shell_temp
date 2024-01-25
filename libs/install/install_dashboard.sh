#!/bin/bash

install_dashboard() {
    cd $pwd/tools/k8s && kubectl apply -f dashboard.yaml
}
