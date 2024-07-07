#!/bin/bash

for type in load a b c d e f;
do
        echo $type
        pwd

         # run_script를 실행합니다
         ./run_script.sh --type physical --pref --input ../../redis/src/redis-server ../../redis/src/redis.conf &
         sleep 5

        # YCSB를 실행합니다
        cd ../../YCSB
        if [ "$type" == "load" ]; then
                ./bin/ycsb load redis -s -P workloads/workloada -p "redis.host=127.0.0.1" -p "redis.port=6378" -p "redis.timeout=10000000" -threads 100
        else
                ./bin/ycsb load redis -s -P workloads/workload$type -p "redis.host=127.0.0.1" -p "redis.port=6378" -p "redis.timeout=10000000" -threads 100
                ./bin/ycsb run redis -s -P workloads/workload$type -p "redis.host=127.0.0.1" -p "redis.port=6378" -p "redis.timeout=10000000" -threads 100
        fi

        # kill process
        pid_redis=$(sudo ps -e | grep callgrind | awk '{print $1}')
        kill $pid_redis

        # 파일 적절한 폴더로 이동
        cd ../trace_generator/run_script
        if [ "$type" == "load" ]; then
                dir_result="result/$type"
        else
                dir_result="result/run_workload_$type"
        fi

        mkdir "$dir_result"
        mv $(ls -t callgrind.* | head -n 1) $dir_result
        mv trace_prefON.v* $dir_result

        cd $dir_result
        echo "현재 경로"
        pwd

        python3 ../../../after_run/mix_vpmap.py ./trace_prefON.vout

        echo "mix -> pout"
        python3 ../../../after_run/make_physical_trace_ts.py ./trace_prefON.mix
        python3 ../../../after_run/graph/cg_histogram.py -i trace_prefON.vout --scatter 103
        python3 ../../../after_run/graph/cg_histogram.py -i trace_prefON.vout --cdf
        python3 ../../../after_run/graph/cg_pa_histogram.py -i trace_prefON.pout --scatter 103

        cd ../../
        pwd
done

