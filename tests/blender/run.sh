docker run \
  --name=blender \
  --security-opt seccomp=unconfined `#optional` \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=Etc/UTC \
  -e SUBFOLDER=/ `#optional` \
  -p 3000:3000 \
  -p 3001:3001 \
  -v /path/to/config:/config \
	--gpus all \
	-e NVIDIA_VISIBLE_DEVICES=all \
	--device /dev/dri:/dev/dri \
	--rm \
  lscr.io/linuxserver/blender:latest
