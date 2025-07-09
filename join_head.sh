# head node
export HF_HUB_CACHE=/root/.cache/huggingface
export VLLM_CACHE_ROOT=/project/a/aspuru/foucault/.cache/vllm2
apptainer exec --nv -B ${HF_HOME}/hub:/root/.cache/huggingface -B /project/a/aspuru/foucault/.cache -B /project/a/aspuru/foucault/.cache/vllm2 .cache/vllm-openai_latest.sif /bin/bash
#Apptainer>
ray start --head --port=6379

# bash ~/startup/run_cluster.sh .cache/vllm-openai_latest.sif balam005 --head $HF_HOME

# run worker node
export HF_HUB_CACHE=/root/.cache/huggingface
export VLLM_CACHE_ROOT=/project/a/aspuru/foucault/.cache/vllm2
apptainer exec --nv -B ${HF_HOME}/hub:/root/.cache/huggingface -B /project/a/aspuru/foucault/.cache -B /project/a/aspuru/foucault/.cache/vllm2 .cache/vllm-openai_latest.sif /bin/bash

# run vllm
#Apptainer>
ray start --address='172.16.30.45:6379'
export VLLM_HOST_IP=172.16.30.46
vllm serve "deepseek-ai/DeepSeek-R1-0528-Qwen3-8B" --tensor-parallel-size 4 --pipeline-parallel-size 2
