# docker run -it --rm \
#   --device /dev/rngd:/dev/rngd \
#   --security-opt seccomp=unconfined \
#   --env HF_TOKEN=$HF_TOKEN \
#   -v $HOME/.cache/huggingface:/root/.cache/huggingface \
#   -p 8000:8000 \
#   furiosaai/furiosa-llm:latest \
#   serve furiosa-ai/Qwen3-32B-FP8


# docker run -it --rm \
#   --device /dev/rngd:/dev/rngd \
#   --security-opt seccomp=unconfined \
#   --env HF_TOKEN=$HF_TOKEN \
#   -v $HOME/.cache/huggingface:/root/.cache/huggingface \
#   -p 8000:8000 \
#   furiosaai/furiosa-llm:latest \
#   serve furiosa-ai/Qwen3-32B-FP8 \
#   --devices npu:0,npu:1,npu:3,npu:3



# docker run -d --rm \
#   --name furiosa-llm-llama \
#   --device /dev/rngd:/dev/rngd \
#   --security-opt seccomp=unconfined \
#   --env HF_TOKEN=$HF_TOKEN \
#   -v $HOME/.cache/huggingface:/root/.cache/huggingface \
#   -p 8000:8000 \
#   furiosaai/furiosa-llm:latest \
#   serve furiosa-ai/llama-3.1-8b-instruct \
#   --devices npu:1


docker run -it --rm \
  --device /dev/rngd:/dev/rngd \
  --security-opt seccomp=unconfined \
  --env HF_TOKEN=$HF_TOKEN \
  -v $HOME/.cache/huggingface:/root/.cache/huggingface \
  -p 8000:8000 \
  furiosaai/furiosa-llm:latest \
  serve furiosa-ai/Qwen2.5-0.5B-Instruct \
  --devices npu:0 &