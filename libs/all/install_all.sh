#!/bin/bash

install_all() {
    ssh_login
    # import_docker_images
    install_nfs
    install_nfs_provisioner
    install_kubefate
    install_fate
    install_fate_serving
    install_middleware
    install_fedx
    install_fedx-custom
}
