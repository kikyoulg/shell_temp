#!/bin/bash

install_fedx_all() {
    for fedx_ns in {fedx-1000,fedx-1100,fedx-2000}; do
        if [ $fedx_ns == fedx-1000 ]; then
            party_id=1000
            install_fedx
        elif [ $fedx_ns == fedx-1100 ]; then
            party_id=1100
            install_fedx
        else
            party_id=2000
            install_fedx
        fi
    done
}
