# #!/bin/bash
#
#
# Title(){
#
# echo -e " ===================================================================="
# echo -e "||                                                                 ||"
# echo -e "|| \033[31;32m 脚本只能检测服务是否正常启动，检测结果不代表服务所有功能正常 \033[0m  ||"
# echo -e "||                                                                 ||"
# echo -e " ===================================================================="
#
# }
#
#
# osnamespace=aps-os
# modelnamespace=aps-serving
#
# service_status() {
#  curl -Ls --connect-timeout 5  -o /dev/null http://${1}.${4}.svc.cluster.local:${2}${3}
#
#  if [ $? -ne 0 ];then
#     printf "\033[0;32;32m服务名：\033[m %-16s   \033[0;32;31m 状态: 检测未通过\033[m\n" $1
#  else
#     printf "\033[0;32;32m服务名：\033[m %-16s   \033[0;32;32m 状态: 检测通过\033[m\n" $1
#  fi
# }
#
# serverlist(){
#  cat << EOF > serverlist.txt
# heron-svc            8080 /   $osnamespace
# falcon-svc           8080 /   $osnamespace
# pipes-svc            8080 /   $osnamespace
# daas-svc             8080 /   $osnamespace
# compass-svc          8080 /   $osnamespace
# controller-svc       8080 /   $osnamespace
# mdserver-svc         8080 /   $osnamespace
# mpserver-svc         8080 /   $osnamespace
# oauthserver-svc      8080 /   $osnamespace
# openapiv1-svc        8080 /   $osnamespace
# recorder-svc         8080 /   $osnamespace
# uums-svc             8080 /   $osnamespace
# specserver-svc       8080 /   $osnamespace
# msserver-svc         8080 /   $osnamespace
# mrserver-svc         8080 /   $osnamespace
# livywrapper-svc      8080 /   $osnamespace
# livyserver-svc       8998 /   $osnamespace
# tenantserver-svc     8080 /   $osnamespace
# tenantwebhook-svc    443  /   $osnamespace
# EOF
# }
#
# # Title
# # serverlist
# check(){
#   while read line;do
#       appname=$(echo $line|awk '{print $1}')
#       port=$(echo $line|awk '{print $2}')
#       url=$(echo $line|awk '{print $3}')
#       ns=$(echo $line|awk '{print $4}')
#       service_status $appname $port $url $ns
#   done < serverlist.txt
# }
#
