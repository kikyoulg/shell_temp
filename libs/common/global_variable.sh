#!/bin/bash

current_time=$(date +"%Y-%m-%d-%H:%M:%S")
pwd=$(dirname $(readlink -f "$0"))/../
env=$2
party_id=$3
nfs_path=$(grep nfsPath $pwd/config/$env/fedx/${party_id}.yaml | cut -f2 -d":" | sed 's/^[ \t]*//g')
master_ip=$(grep nfsServer $pwd/config/$env/fedx/${party_id}.yaml | cut -f2 -d":" | sed 's/^[ \t]*//g')
