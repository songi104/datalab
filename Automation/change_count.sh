#!/bin/sh

# 인수로 받은 숫자를 count 변수에 저장합니다.
count=$1


for type in a b c d e f
do
        # 변경할 파일 경로를 변수에 저장합니다.
        file_path="../../YCSB/workloads/workload$type"

        # 인수로 받은 count가 숫자인지 확인합니다.
        if ! echo "$count" | grep -Eq '[0-9]+$'; then
            echo "Error: The input must be a number."
            exit 1
        fi

        # 파일이 존재하는지 확인합니다.
        if [ ! -f "$file_path" ]; then
            echo "Error: File not found at $file_path"
            exit 1
        fi

        # sed 명령어를 사용하여 recordcount와 operationcount 값을 변경합니다.
        sed -i "s/^recordcount=[0-9]\+/recordcount=$count/" "$file_path"
        sed -i "s/^operationcount=[0-9]\+/operationcount=$count/" "$file_path"

        echo "recordcount and operationcount have been updated to $count in $file_path"
done

