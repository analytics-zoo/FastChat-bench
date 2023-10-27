export MODEL_PATH=YOUR_MODE_PATH
export DOCKER_IMAGE=10.239.45.10/arda/intelanalytics/bigdl-llm-serving-cpu:2.4.0-SNAPSHOT
sudo docker run -itd \
        --net=host \
        --cpuset-cpus="Normally 4 cores" \
        --cpuset-mems="0" \
        --memory="16G" \
        --name=fastchat-controller \
        --shm-size="16g" \
        -e CONTROLLER_HOST="YOUR_HOST_IP" \ # Change this
        -e CONTROLLER_PORT="21005" \
        -e API_HOST="YOUR_HOST_IP" \ # Change this
        -e API_PORT="8000" \
        -e ENABLE_PERF_OUTPUT=true \
        -v $MODEL_PATH:/ppml/models \
        $DOCKER_IMAGE -m controller

sudo docker run -itd \
        --net=host \
        --cpuset-cpus="Normally 48 cores" \
        --cpuset-mems="0" \
        --memory="64G" \
        --name=fastchat-worker-1 \
        --shm-size="16g" \
        -e CONTROLLER_HOST="YOUR_HOST_IP" \ # Change this
        -e CONTROLLER_PORT="21005" \
        -e WORKER_HOST="YOUR_HOST_IP" \ # Change this
        -e WORKER_PORT="21840" \
        -e OMP_NUM_THREADS="48" \
        -e ENABLE_PERF_OUTPUT=true \
        -e MODEL_PATH=/ppml/models/Llama-2-7b-chat-hf-bigdl \  # Please change this model
        -v $MODEL_PATH:/ppml/models \
        $DOCKER_IMAGE -m worker


sudo docker run -itd \
        --net=host \
        --cpuset-cpus="Normally 48 cores" \
        --cpuset-mems="0" \
        --memory="64G" \
        --name=fastchat-worker-2 \
        --shm-size="16g" \
       -e CONTROLLER_HOST="YOUR_HOST_IP" \ # Change this
       -e CONTROLLER_PORT="21005" \
       -e WORKER_HOST="YOUR_HOST_IP" \ # Change this
       -e WORKER_PORT="21841" \
       -e OMP_NUM_THREADS="48" \
       -e ENABLE_PERF_OUTPUT=true \
       -e MODEL_PATH=/ppml/models/Llama-2-7b-chat-hf \ # Please change this model
       -v $MODEL_PATH:/ppml/models \
       $DOCKER_IMAGE -m worker
