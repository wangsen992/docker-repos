docker run \
	--name=cuda-test \
	--gpus all \
	--rm \
	nvidia/cuda:11.0.3-base-ubuntu20.04 \
	nvidia-smi
