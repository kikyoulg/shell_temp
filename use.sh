#!/bin/bash

# set -u

for i in $(find libs/* -type f); do
    source $i &>/dev/null
done

if [ $1 == install ]; then
    if [ $3 == 1000 ]; then
        env=$2
        fate_ns=fate-1000
        fedx_ns=fedx-1000
    elif [ $3 == 1100 ]; then
        env=$2
        fate_ns=fate-1100
        fedx_ns=fedx-1100
    elif [ $3 == 2000 ]; then
        env=$2
        fate_ns=fate-2000
        fedx_ns=fedx-2000
    else
        echo "error"
    fi
elif [ $1 == uninstall ]; then
    if [ $3 == 1000 ]; then
        env=$2
        fate_ns=fate-1000
        fedx_ns=fedx-1000
    elif [ $3 == 1100 ]; then
        env=$2
        fate_ns=fate-1100
        fedx_ns=fedx-1100
    elif [ $3 == 2000 ]; then
        env=$2
        fate_ns=fate-2000
        fedx_ns=fedx-2000
    else
        echo "error"
    fi
elif [ $1 == touch_log ]; then
    touch_log
elif [ $1 == pre_check ]; then
    pre_check
elif [ $1 == ssh_login ]; then
    ssh_login
elif [ $1 == import_docker_images ]; then
    import_docker_images
elif [ $1 == install_nfs ]; then
    install_nfs
elif [ $1 == install_nfs_provisioner ]; then
    install_nfs_provisioner
elif [ $1 == install_kubefate ]; then
    install_kubefate
elif [ $1 == install_fate ]; then
    if [ $3 == 1000 ]; then
        fate_ns=fate-1000
        install_fate
    elif [ $3 == 1100 ]; then
        party_id=$3
        fate_ns=fate-1100
        install_fate
    elif [ $3 == 2000 ]; then
        party_id=$3
        fate_ns=fate-2000
        install_fate
    else
        echo "error"
    fi
elif [ $1 == install_fate-serving ]; then
    if [ $3 == 1000 ]; then
        serving_ns=fate-serving-1000
        install_fate-serving
    elif [ $3 == 1100 ]; then
        serving_ns=fate-serving-1100
        install_fate-serving
    elif [ $3 == 2000 ]; then
        serving_ns=fate-serving-2000
        install_fate-serving
    else
        echo "error"
    fi
elif [ $1 == install_fedx-custom ]; then
    if [ $3 == 1000 ]; then
        fedx_custom_ns=fedx-custom-1000
        party_id=1000
        install_fedx-custom
    elif [ $3 == 1100 ]; then
        fedx_custom_ns=fedx-custom-1100
        party_id=1100
        install_fedx-custom
    elif [ $3 == 2000 ]; then
        fedx_custom_ns=fedx-custom-2000
        party_id=2000
        install_fedx-custom
    else
        echo "error"
    fi
elif [ $1 == install_fedx ]; then
    if [ $3 == 1000 ]; then
        fedx_ns=fedx-1000
        install_fedx
    elif [ $3 == 1100 ]; then
        fedx_ns=fedx-1100
        install_fedx
    elif [ $3 == 2000 ]; then
        fedx_ns=fedx-2000
        install_fedx
    else
        echo "error"
    fi
elif [ $1 == install_bsd ]; then
    if [ $3 == 1000 ]; then
        bsd_ns=bsd-1000
        install_bsd
    elif [ $3 == 1100 ]; then
        bsd_ns=bsd-1100
        install_bsd
    elif [ $3 == 2000 ]; then
        bsd_ns=bsd-2000
        install_bsd
    else
        echo "error"
    fi
elif [ $1 == install_fedx_scql ]; then
    if [ $3 == 1000 ]; then
        fedx_ns=fedx-1000
        install_fedx_scql
    elif [ $3 == 1100 ]; then
        fedx_ns=fedx-1100
        install_fedx_scql
    elif [ $3 == 2000 ]; then
        fedx_ns=fedx-2000
        install_fedx_scql
    else
        echo "error"
    fi
elif [ $1 == install_middleware ]; then
    if [ $3 == 1000 ]; then
        fedx_ns=fedx-1000
        install_middleware
    elif [ $3 == 1100 ]; then
        fedx_ns=fedx-1100
        install_middleware
    elif [ $3 == 2000 ]; then
        fedx_ns=fedx-2000
        install_middleware
    else
        echo "error"
    fi
elif [ $1 == install_bsd_middleware ]; then
    if [ $3 == 1000 ]; then
        bsd_ns=bsd-1000
        install_bsd_middleware
    elif [ $3 == 1100 ]; then
        bsd_ns=bsd-1100
        install_bsd_middleware
    elif [ $3 == 2000 ]; then
        bsd_ns=bsd-2000
        install_bsd_middleware
    else
        echo "error"
    fi
elif [ $1 == uninstall_middleware ]; then
    if [ $2 == 1000 ]; then
        fedx_ns=fedx-1000
        uninstall_middleware
    elif [ $2 == 1100 ]; then
        fedx_ns=fedx-1100
        uninstall_middleware
    elif [ $2 == 2000 ]; then
        fedx_ns=fedx-2000
        uninstall_middleware
    else
        echo "error"
    fi
elif [ $1 == uninstall_fedx-custom ]; then
    if [ $2 == 1000 ]; then
        fedx_ns=fedx-custom-1000
        uninstall_fedx-custom
    elif [ $2 == 1100 ]; then
        fedx_ns=fedx-custom-1100
        uninstall_fedx-custom
    elif [ $2 == 2000 ]; then
        fedx_ns=fedx-custom-2000
        uninstall_fedx-custom
    else
        echo "error"
    fi
elif [ $1 == uninstall_kubefate ]; then
    uninstall_kubefate
elif [ $1 == uninstall_fate ]; then
    if [ $2 == 1000 ]; then
        fate_ns=fate-1000
        uninstall_fate
    elif [ $2 == 1100 ]; then
        fate_ns=fate-1100
        uninstall_fate
    elif [ $2 == 2000 ]; then
        fate_ns=fate-2000
        uninstall_fate
    else
        echo "error"
    fi
elif [ $1 == uninstall_fate-serving ]; then
    if [ $2 == 1000 ]; then
        fate_ns=fate-1000
        uninstall_fate-serving
    elif [ $2 == 1100 ]; then
        fate_ns=fate-1100
        uninstall_fate-serving
    elif [ $2 == 2000 ]; then
        fate_ns=fate-2000
        uninstall_fate-serving
    else
        echo "error"
    fi
elif [ $1 == uninstall_fedx ]; then
    if [ $2 == 1000 ]; then
        fedx_ns=fedx-1000
        uninstall_fedx
    elif [ $2 == 1100 ]; then
        fedx_ns=fedx-1100
        uninstall_fedx
    elif [ $2 == 2000 ]; then
        fedx_ns=fedx-2000
        uninstall_fedx
    else
        echo "error"
    fi
elif [ $1 == delete_pvc_fate ]; then
    if [ $2 == 1000 ]; then
        fate_ns=fate-1000
        delete_pvc_fate
    elif [ $2 == 1100 ]; then
        fate_ns=fate-1100
        delete_pvc_fate
    elif [ $2 == 2000 ]; then
        fate_ns=fate-2000
        delete_pvc_fate
    else
        echo "error"
    fi
elif [ $1 == check_toy ]; then
    check_toy
elif [ $1 == reset_mysql ]; then
    reset_mysql
elif [ $1 == update_version ]; then
    update_version
elif [ $1 == install_longhorn ]; then
    echo "install_longhorn脚本已删除"
elif [ $1 == check_toy_all ]; then
    check_toy_all
elif [ $1 == check_pulsar ]; then
    check_pulsar
elif [ $1 == reset ]; then
    reset
elif [ $1 == install_all ]; then
    touch_log
    if [ "$3" = "1000" ]; then
        env=$2
        fate_ns=fate-1000
        fedx_ns=fedx-1000
        serving_ns=fate-serving-1000
        fedx_custom_ns=fedx-custom-1000
        install_all 2>&1 | tee -i $pwd/${current_time}.log
    elif [ "$3" = "1100" ]; then
        env=$2
        fate_ns=fate-1100
        fedx_ns=fedx-1100
        serving_ns=fate-serving-1100
        fedx_custom_ns=fedx-custom-1100
        install_all 2>&1 | tee -i $pwd/${current_time}.log
    elif [ "$3" = "2000" ]; then
        env=$2
        fate_ns=fate-2000
        fedx_ns=fedx-2000
        serving_ns=fate-serving-2000
        fedx_custom_ns=fedx-custom-2000
        install_all 2>&1 | tee -i $pwd/${current_time}.log
    else
        echo "error"
    fi
elif [ $1 == uninstall_all ]; then
    if [ $2 == 1000 ]; then
        fate_ns=fate-1000
        fedx_ns=fedx-1000
        fedx_custom_ns=fedx-custom-1000
        uninstall_all
    elif [ $2 == 1100 ]; then
        fate_ns=fate-1100
        fedx_ns=fedx-1100
        fedx_custom_ns=fedx-custom-1100
        uninstall_all
    elif [ $2 == 2000 ]; then
        fate_ns=fate-2000
        fedx_ns=fedx-2000
        fedx_custom_ns=fedx-custom-2000
        uninstall_all
    else
        echo "error"
    fi
elif [ $1 == delete_pvc_all ]; then
    if [ $2 == 1000 ]; then
        fate_ns=fate-1000
        fedx_ns=fedx-1000
        fedx_custom_ns=fedx-custom-1000
        delete_pvc_all
    elif [ $2 == 1100 ]; then
        fate_ns=fate-1100
        fedx_ns=fedx-1100
        fedx_custom_ns=fedx-custom-1100
        delete_pvc_all
    elif [ $2 == 2000 ]; then
        fate_ns=fate-2000
        fedx_ns=fedx-2000
        fedx_custom_ns=fedx-custom-2000
        delete_pvc_all
    else
        echo "error"
    fi
elif [ $1 == restart_pod ]; then
    restart_pod
elif [ $1 == update_sql ]; then
    update_sql
elif [ $1 == init_sql ]; then
    if [ $3 == 1000 ]; then
        fedx_ns=fedx-1000
        init_sql
    elif [ $3 == 1100 ]; then
        fedx_ns=fedx-1100
        init_sql
    elif [ $3 == 2000 ]; then
        fedx_ns=fedx-2000
        init_sql
    else
        echo "error"
    fi
elif [ $1 == save_images ]; then
    save_images
else
    echo -e "\033[42;37m 参数错误 \033[0m"
fi
