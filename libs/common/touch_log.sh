#!/bin/bash

touch_log() {
    if [[ -e $pwd/$install_log ]]; then
        touch $pwd/${current_time}.log
    fi
}
