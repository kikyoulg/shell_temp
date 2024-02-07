#!/bin/bash

delete_pvc_fedx-custom() {
    kubectl get pvc -n${fedx_custom_ns} | awk '{print $1}' | grep -v NAME | xargs kubectl -n${fedx_custom_ns} delete pvc
}
