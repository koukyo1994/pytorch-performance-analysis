IMG := pytorch-performance-analysis
TAG := 2020.3.23
NAME := pytorch-performance
USER := user

docker-build:
	make -C docker/ IMG=${IMG} TAG=${TAG}

env:
	docker run --rm -it --init \
	--name ${NAME} \
	--volume `pwd`:/app/${NAME} \
	-w /app/${NAME} \
	--user `id -u`:`id -g` \
	--publish 9000:9000 \
	--cpuset-cpus=0-3 \
	--memory=2gb \
	--oom-kill-disable \
	--shm-size=500mb \
	${IMG}:${TAG} /bin/bash

jupyter:
	sudo chown ${USER}:${USER} /home/user/.jupyter
	jupyter lab --port 9000 --ip 0.0.0.0 --NotebookApp.token=
