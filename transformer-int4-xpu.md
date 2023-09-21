# Test transformer-int4 performance

Image used: [Dockerfile](https://github.com/intel-analytics/BigDL/blob/main/docker/llm/inference/xpu/docker/Dockerfile)

When you start the docker, remember to set `--cpuset-cpus` and `--cpuset-mems` to the correct value.

Example for booting the container:

```bash
#/bin/bash
# You may need to build the image from the Dockerfile first
export DOCKER_IMAGE=10.239.45.10/arda/intelanalytics/bigdl-llm-xpu:2.4.0-SNAPSHOT

sudo docker run -itd \
        --net=host \
        --device=/dev/dri \
        --memory="32G" \
        --name=CONTAINER_NAME \
        --shm-size="16g" \
        $DOCKER_IMAGE
```

## Environment variable setting:

According to the `bigdl-llm` introduction, we would only need to set the following two envs when using xpu:

```bash
export USE_XETLA=OFF
export SYCL_PI_LEVEL_ZERO_USE_IMMEDIATE_COMMANDLISTS=1
```

## Benchmark script

As usual, we would use [this](https://github.com/intel-analytics/BigDL/tree/main/python/llm/dev/benchmark) for testing.

## Prompt:

Usually we test 32 input, 32 output.  Below is a 32 input prompt:

"Once upon a time, there existed a little girl who liked to have adventures. She wanted to go to places and meet new people, and have fun"

To ensure the input is 32-tokens long, do the following change in `/ppml/bench/bench.py`

```python
            input_ids = tokenizer.encode(input_str, return_tensors="pt")

            print("input length is : ", input_ids.shape[1])
```

Also, sometimes, we need to change `AutoModel.from_pretrained` to `AutoModelForCausalLM.from_pretrained` to avoid errors.