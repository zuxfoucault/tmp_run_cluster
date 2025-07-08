# head node
bash ~/startup/run_cluster.sh .cache/vllm-openai_latest.sif balam005 --head $HF_HOME

# run worker node
apptainer exec --nv -B ${HF_HOME}:/root/.cache/huggingface -B ~ -B ~/project -B ~/.cache .cache/vllm-openai_latest.sif /bin/bash

# in the worker container, joining head
#Apptainer>
ray start --address='172.16.30.45:6379'

# run vllm
vllm serve "deepseek-ai/DeepSeek-R1-0528-Qwen3-8B" --tensor-parallel-size 4
