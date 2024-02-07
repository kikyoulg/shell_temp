#/bin/bash

cd /home/fedx/fedx-install/ && git pull && ./helm upgrade fedx fedx/ -f config/zetyun-dev/fedx/1000.yaml -nfedx-1000
cd /home/fedx/fedx-install/ && git pull && ./helm upgrade fedx fedx/ -f config/zetyun-dev/fedx/1100.yaml -nfedx-1100
cd /home/fedx/fedx-install/ && git pull && ./helm upgrade fedx fedx/ -f config/zetyun-dev/fedx/2000.yaml -nfedx-2000
