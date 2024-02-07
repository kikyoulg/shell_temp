#/bin/bash

cd /home/fedx/fedx-install/ && git pull && ./helm upgrade  fedx-custom fedx-custom -f config/zetyun-dev/fedx-custom/1000.yaml -nfedx-custom-1000
cd /home/fedx/fedx-install/ && git pull && ./helm upgrade  fedx-custom fedx-custom -f config/zetyun-dev/fedx-custom/1100.yaml -nfedx-custom-1100
cd /home/fedx/fedx-install/ && git pull && ./helm upgrade  fedx-custom fedx-custom -f config/zetyun-dev/fedx-custom/2000.yaml -nfedx-custom-2000