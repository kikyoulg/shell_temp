{{/* Generate basic labels */}}
{{- define "mychart.labels" }}
name: {{ .Chart.Name }}
version: {{ .Chart.Version }}
{{- end }}

{{- define "initContainers" }}
- image: registry.zet-fl.com/fedx/mysql:8.0.26
  imagePullPolicy: IfNotPresent
  name: ping-mysql
  env:
  - name: MYSQL_DATABASE
    value: "{{ .Values.mysql.name | default "fedx" }}"
  - name: MYSQL_USER
    value: "{{ .Values.mysql.user | default "root" }}"
  - name: MYSQL_PASSWORD
    value: "{{ .Values.mysql.passwd | default "Wa@123456" }}"
  - name: MYSQL_HOST
    value: "{{ .Values.mysql.host | default "mysql" }}"
  - name: MYSQL_PORT
    value: "{{ .Values.mysql.port | default "3306" }}"
  command:
  - /bin/bash
  - -c
  - |
    set -x
    function checkMySQL(){
      checkMySQLCount=0
      while true ; do
        checkMySQLCount=$[checkMySQLCount+1]
        echo "Waiting for mysql started. check count: $checkMySQLCount"
        sleep
        state=`mysqladmin ping -h ${MYSQL_HOST} --port=${MYSQL_PORT} -u${MYSQL_USER} -p${MYSQL_PASSWORD}| awk '{print $3}'`
        if [ "$state" == "alive" ]; then
          echo "mysql server has been already started."
        break
        fi
     done
    }
    echo "Waiting for mysql started..."
    checkMySQL
{{- end }}