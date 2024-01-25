#!/bin/bash

delete_fate_all() {
    array=(fate-1000 fate-1100 fate-2000)
    for i in "${array[@]}"; do
        cd $pwd
        ./kubefate cluster ls | grep $i | awk '{print $1}' | xargs ./kubefate cluster del
    done
}
