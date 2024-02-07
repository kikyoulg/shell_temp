#!/bin/bash

check_toy() {
    case $env in
    ab)
        temp_ns=fate-1000
        env=ab
        ;;
    ba)
        temp_ns=fate-1100
        env=ba
        ;;
    ac)
        temp_ns=fate-1000
        env=ac
        ;;
    ca)
        temp_ns=fate-2000
        env=ca
        ;;
    bc)
        temp_ns=fate-1100
        env=bc
        ;;
    cb)
        temp_ns=fate-2000
        env=cb
        ;;
    all)
        check_toy_all
        ;;
    esac
    pythonPod=$(kubectl get pod -n${temp_ns} | grep python | awk '{print $1}')
    kubectl cp $pwd/tools/json $pythonPod:/json -n${temp_ns}
    kubectl -n${temp_ns} exec -it $pythonPod -- python /data/projects/fate/fateflow/python/fate_flow/fate_flow_client.py -f submit_job -d /json/toy_example_dsl.json -c /json/$env.json
}

check_toy_all() {
    for i in {fate-1000,fate-1100,fate-2000}; do
        pythonPod=$(kubectl get pod -n$i | grep python | awk '{print $1}')
        kubectl cp $pwd/tools/json $pythonPod:/json -n$i
    done
    kubectl exec -it -nfate-1000 $(kubectl get pod -nfate-1000 | grep python | awk '{print $1}') -- python /data/projects/fate/fateflow/python/fate_flow/fate_flow_client.py -f submit_job -d /json/toy_example_dsl.json -c /json/ab.json
    sleep 2
    kubectl exec -it -nfate-1000 $(kubectl get pod -nfate-1000 | grep python | awk '{print $1}') -- python /data/projects/fate/fateflow/python/fate_flow/fate_flow_client.py -f submit_job -d /json/toy_example_dsl.json -c /json/ac.json
    sleep 2
    kubectl exec -it -nfate-1100 $(kubectl get pod -nfate-1100 | grep python | awk '{print $1}') -- python /data/projects/fate/fateflow/python/fate_flow/fate_flow_client.py -f submit_job -d /json/toy_example_dsl.json -c /json/ba.json
    sleep 2
    kubectl exec -it -nfate-1100 $(kubectl get pod -nfate-1100 | grep python | awk '{print $1}') -- python /data/projects/fate/fateflow/python/fate_flow/fate_flow_client.py -f submit_job -d /json/toy_example_dsl.json -c /json/bc.json
    sleep 2
    kubectl exec -it -nfate-2000 $(kubectl get pod -nfate-2000 | grep python | awk '{print $1}') -- python /data/projects/fate/fateflow/python/fate_flow/fate_flow_client.py -f submit_job -d /json/toy_example_dsl.json -c /json/ca.json
    sleep 2
    kubectl exec -it -nfate-2000 $(kubectl get pod -nfate-2000 | grep python | awk '{print $1}') -- python /data/projects/fate/fateflow/python/fate_flow/fate_flow_client.py -f submit_job -d /json/toy_example_dsl.json -c /json/cb.json
}
