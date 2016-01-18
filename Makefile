IMAGE = ploxiln/statsdaemon
VERSION = 0.7.1

MAKEFLAGS += -r # no built-in rules
DOCKER = docker # to run docker with sudo, do `make DOCKER="sudo docker"`

TARBALL = statsdaemon-${VERSION}.linux-amd64.go1.4.2.tar.gz

DATE := $(shell date +%Y-%m-%d)
BASE_IMAGE = $(shell awk '/^FROM/ {print $$2}' Dockerfile)

build: ${TARBALL}
	${DOCKER} pull ${BASE_IMAGE}
	tar -x --strip-components 1 -f ${TARBALL}
	${DOCKER} build --tag=${IMAGE} .

push:
	${DOCKER} tag ${IMAGE} ${IMAGE}:${VERSION}
	${DOCKER} tag ${IMAGE} ${IMAGE}:${DATE}
	${DOCKER} push ${IMAGE}

${TARBALL}:
	wget https://github.com/bitly/statsdaemon/releases/download/v${VERSION}/${TARBALL}

clean:
	rm -f ${TARBALL} statsdaemon

.PHONY: build push clean
