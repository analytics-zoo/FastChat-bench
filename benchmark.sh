#!/bin/bash

export thread_num=$1
export warmup_time='2m'
export duration='10m'
export openai_api_address='http://localhost:18001/v1/completions'
export lua_script='./wrk-scripts/compl_1024.lua'

# Warm Up
wrk -t$thread_num -c$thread_num -d$warmup_time -s $lua_script $openai_api_address --timeout 1m
python ./calc_token_time.py
echo '--------------------- Benchmark start -----------------------'
# Benchmark
timestamp=$(date +"%Y-%m-%d %H:%M:%S")
echo "timestamp: $timestamp"
wrk -t$thread_num -c$thread_num -d$duration -s $lua_script $openai_api_address --timeout 1m

python ./calc_token_time.py
echo '---------------------- Benchmark end ------------------------'
