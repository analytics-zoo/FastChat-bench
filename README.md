# FastChat Benchmark

This repo contains the files that are used for FastChat benchmark.


## Start service

You can either start the service using `docker` or `kubernetes`, check the `README.md` in `kubernetes` folder for detailed instruction.

As for docker, it is quite obvious on how to start the service.

## Environment variable settings

For testing performance on CPU, we recommend to use `Intel-OpenMP` and `tcmalloc` for acceleration.

```bash
source bigdl-nano-init -t
export OMP_NUM_THREADS="YOUR_CORE_NUMBERS"
```


## Test

We use `wrk` for testing end-to-end throughput, check [here](https://github.com/wg/wrk).

Please change the test url accordingly.

If you have multiple worker containers/pods, set t/c to the number of backend workers to test full throughput.

```bash
# For testing completions
 wrk -t1 -c1 -d20m -s ./wrk-scripts/compl.lua http://172.168.0.218:8000/v1/completions --timeout 1m

# For testing chat completions
wrk -t1 -c1 -d20m -s ./wrk-scripts/chat.lua http://172.168.0.218:8000/v1/chat/completions --timeout 1m

```
