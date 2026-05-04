
# Pre-compiled Model	Description	Base Model	Support Version
# furiosa-ai/EXAONE-4.0-32B-FP8	FP8	LGAI-EXAONE/EXAONE-4.0-32B-FP8	>= 2026.1
# furiosa-ai/Llama-3.1-8B-Instruct	BF16	meta-llama/Llama-3.1-8B-Instruct	>= 2025.2
# furiosa-ai/Llama-3.3-70B-Instruct	BF16	meta-llama/Llama-3.3-70B-Instruct	>= 2025.3
# furiosa-ai/Qwen2.5-0.5B-Instruct	BF16	Qwen/Qwen2.5-0.5B-Instruct	>= 2026.1
# furiosa-ai/Qwen3-Embedding-8B	BF16	Qwen/Qwen3-Embedding-8B	>= 2026.1
# furiosa-ai/Qwen3-Reranker-8B	BF16	Qwen/Qwen3-Reranker-8B	>= 2026.1
# furiosa-ai/Qwen3-32B-FP8	FP8	Qwen/Qwen3-32B-FP8	>= 2026.1

# ensure you're in the right environment
# Reranking in RAG is basically a second-pass filter that improves your search results. 
# After initial retrieval pulls documents (vector similarity, etc), 
# the reranker examines each result taking your query into consideration.

# launch with npu 2
docker run -it --rm \
  --device /dev/rngd:/dev/rngd \
  --security-opt seccomp=unconfined \
  --env HF_TOKEN=$HF_TOKEN \
  -v $HOME/.cache/huggingface:/root/.cache/huggingface \
  -p 8002:8002 \
  furiosaai/furiosa-llm:latest \
  serve furiosa-ai/Qwen3-Reranker-8B \
  --port 8002 \
  --devices npu:2