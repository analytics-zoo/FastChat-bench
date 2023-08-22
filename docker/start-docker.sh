export DOCKER_IMAGE=intelanalytics/bigdl-ppml-trusted-fastchat-tdx:test

export MODEL_PATH="YOUR_MODEL_PATH"

sudo docker run -itd \
        --net=host \
        --cpuset-cpus="0-3" \
        --cpuset-mems="0" \
        --memory="16G" \
        --name=fastchat-controller \
        --shm-size="16g" \
        -e CONTROLLER_HOST="172.168.0.218" \
        -e CONTROLLER_PORT="21005" \
        -e API_HOST="172.168.0.218" \
        -e API_PORT="8000" \
        -v $MODEL_PATH:/ppml/models \
        $DOCKER_IMAGE -m controller


sudo docker run -itd \
        --net=host \
        --cpuset-cpus="5-20" \
        --cpuset-mems="0" \
        --memory="128G" \
        --name=fastchat-worker-1 \
        --shm-size="16g" \
        -e CONTROLLER_HOST="172.168.0.218" \
        -e CONTROLLER_PORT="21005" \
        -e WORKER_HOST="172.168.0.218" \
        -e WORKER_PORT="21840" \
        -e MODEL_PATH="/ppml/models/llama-7b-bigdl/" \
        -e OMP_NUM_THREADS="16" \
        -v $MODEL_PATH:/ppml/models \
        $DOCKER_IMAGE

sudo docker run -itd \
        --net=host \
        --cpuset-cpus="22-37" \
        --cpuset-mems="0" \
        --memory="128G" \
        --name=fastchat-worker-2 \
        --shm-size="16g" \
       -e CONTROLLER_HOST="172.168.0.218" \
       -e CONTROLLER_PORT="21005" \
       -e WORKER_HOST="172.168.0.218" \
       -e WORKER_PORT="21841" \
       -e MODEL_PATH="/ppml/models/llama-7b-bigdl/" \
       -e OMP_NUM_THREADS="16" \
       -v $MODEL_PATH:/ppml/models \
       $DOCKER_IMAGE -m worker
