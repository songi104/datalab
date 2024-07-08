# 파일 설명 (Desktop 기준)

auto.sh와 change_count.sh는 서버와 연결된 가상머신에서 사용해야함.

### 가상머신 접속

qemu.sh 파일은 Desktop에 있음.

```
./sudo qemu.sh
```

### sh 파일

- auto.sh

  run_script 폴더에서 실행하면 result 폴더에 결과 생김. (다만 graph 부분 확인이 필요함.)

  ```shell
  cd ~/datalab/trace_generator/run_script
  sudo ./auto.sh
  ```

- change_count.sh:
  recordcount와 operationcount [Number]개로 바꾸는 명령어. run_script 폴더에서 실행.
  ```shell
  cd ~/datalab/trace_generator/run_script
  sudo ./change_count.sh [Number]
  ```

### Desktop 파일

result 폴더

- 모든 result를 모아둠.
- preprocessing_pa.py (physical address 처리하는 파일)
- preprocessing_va.py (virtual address 처리하는 파일)

  입력: 각각 pout, vout로 받음.</br> 출력: graph와 csv

