IMAGE = ploxiln/statsdaemon
VERSION = 0.7.1

MAKEFLAGS += -r # no built-in rules
DOCKER = docker # to run docker with sudo, do `make DOCKER="sudo docker"`

TARBALL = statsdaemon-${VERSION}.linux-amd64.go1.4.2.tar.gz

DATE := $(shell date +%Y-%m-%d)
BASE_IMAGE = $(shell awk '/^FROM/ {print $$2}' Dockerfile)

build: ${TARBALL}
	tar -x --strip-components 1 -f ${TARBALL}
	${DOCKER} pull ${BASE_IMAGE}
	${DOCKER} build --tag=${IMAGE} .

build-src:
	# assuming ../statsdaemon is checked out to the desired revision
	./build-src.sh
	${DOCKER} pull ${BASE_IMAGE}
	${DOCKER} build --tag=${IMAGE} .

push:
	${DOCKER} tag -f ${IMAGE} ${IMAGE}:${VERSION}
	${DOCKER} tag -f ${IMAGE} ${IMAGE}:${DATE}
	${DOCKER} push ${IMAGE}:${VERSION}
	${DOCKER} push ${IMAGE}:${DATE}
	${DOCKER} push ${IMAGE}:latest

${TARBALL}:
	wget https://github.com/bitly/statsdaemon/releases/download/v${VERSION}/${TARBALL}

clean:
	rm -f ${TARBALL} statsdaemon

.PHONY: build push clean
