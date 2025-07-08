# run worker node
apptainer exec --nv -B ${HF_HOME}:/root/.cache/huggingface -B ~ -B ~/project .cache/vllm-openai_latest.sif /bin/bash

# in the worker container, joining head
#Apptainer>
ray start --address='172.16.30.45:6379'

# run vllm
vllm serve "deepseek-ai/DeepSeek-R1-0528-Qwen3-8B" --tensor-parallel-size 4
