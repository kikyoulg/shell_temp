#!/bin/bash

delete_pvc_fate() {
    kubectl get pvc -n$fate_ns | awk '{print $1}' | grep -v NAME | xargs kubectl -n$fate_ns delete pvc
}
