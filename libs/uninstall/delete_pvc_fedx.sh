#!/bin/bash

delete_pvc_fedx() {
    kubectl get pvc -n$fedx_ns | awk '{print $1}' | grep -v NAME | xargs kubectl -n$fedx_ns delete pvc
}
