#!/bin/bash

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    restart_pod
fi

buttons=(
    "rsc-fe-spd"
    "rsc_pir"
    "rsc_service"
    "rsc_mpc"
)

button_num=${#buttons[@]}

rsc-fe-spd() {
  echo "rsc-fe-spd"
}
rsc_pir() {
  echo "rsc_pir-spd"
}
rsc_service() {
  echo "rsc_service"
}
rsc_mpc() {
  echo "rsc_mpc"
}


local temp
local i
i=0
while [ 1 ]
do
    clear
    for((j=0;j<button_num;j++))
    do
        if [ $i -eq $j ]
        then
            echo -e "\033[32m ${buttons[$j]} \033[0m"
        else
            echo " ${buttons[$j]} "
        fi
    done
    read -s -n1 temp
    case "$temp" in
        "A")
            i=`expr $i - 1`
            [ $i -lt 0 ] && i=`expr $button_num - 1`
            ;;
        "B")
            i=`expr $i + 1`
            [ $i -ge $button_num ] && i=0
            ;;
        "")
            eval ${buttons[$i]}
            break
            ;;
    esac
done
