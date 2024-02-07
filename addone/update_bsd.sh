#/bin/bash

cd /home/fedx/fedx-install/ && git pull && ./helm upgrade bsd bsd/ -f config/zetyun-dev/bsd/1000.yaml -nbsd-1000
cd /home/fedx/fedx-install/ && git pull && ./helm upgrade bsd bsd/ -f config/zetyun-dev/bsd/1100.yaml -nbsd-1100
cd /home/fedx/fedx-install/ && git pull && ./helm upgrade bsd bsd/ -f config/zetyun-dev/bsd/2000.yaml -nbsd-2000
