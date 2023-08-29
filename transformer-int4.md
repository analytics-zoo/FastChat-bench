# Test transformer-int4 performance

Image used: 10.239.45.10/arda/intelanalytics/bigdl-ppml-trusted-bigdl-llm-tdx:2.4.0-SNAPSHOT-bench

When you start the docker, remember to set `--cpuset-cpus` and `--cpuset-mems` to the correct value.

## Environment variable setting:

We could use bigdl-nano to set corresponding env variables:

```bash
source bigdl-nano-init -t 

# After that, change OMP_NUM_THREADS to the correct number:
export OMP_NUM_THREADS="xxx"
```

## Prompt:

Usually we test 32 input, 32 output.  Below is a 32 input prompt:

"Once upon a time, there existed a little girl who liked to have adventures. She wanted to go to places and meet new people, and have fun"

To ensure the input is 32-tokens long, do the following change in `/ppml/bench/bench.py`

```python
            input_ids = tokenizer.encode(input_str, return_tensors="pt")

            print("input length is : ", input_ids.shape[1])
```

Also, sometimes, we need to change `AutoModel.from_pretrained` to `AutoModelForCausalLM.from_pretrained` to avoid errors.