#!/bin/bash

install_fate_serving_all() {
    for fate_ns in {fate-1000,fate-1100,fate-2000}; do
        if [ $fate_ns == fate-1000 ]; then
            party_id=1000
            install_fate_serving
        elif [ $fate_ns == fate-1100 ]; then
            party_id=1100
            install_fate_serving
        else
            party_id=2000
            install_fate_serving
        fi
    done
}
