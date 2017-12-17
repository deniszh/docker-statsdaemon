IMAGE = ploxiln/statsdaemon

MAKEFLAGS = r  # disable built-in rules
DOCKER = sudo docker
DATE := $(shell date +%Y-%m-%d)

build:
	awk '/^FROM\s/ {print $$2}' Dockerfile \
	    | while read IMAGE ; do ${DOCKER} pull $$IMAGE ; done
	${DOCKER} build --tag=${IMAGE} .

push:
	${DOCKER} tag ${IMAGE} ${IMAGE}:${DATE}
	${DOCKER} push ${IMAGE}:${DATE}
	${DOCKER} push ${IMAGE}:latest

.PHONY: build push
