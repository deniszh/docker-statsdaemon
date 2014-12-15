NAME = statsdaemon
VERSION = 0.6-alpha

TARBALL = ${NAME}-${VERSION}.linux-amd64.go1.3.tar.gz
IMAGE = ploxiln/${NAME}
DATE := $(shell date +%Y-%m-%d)

MAKEFLAGS += -r # no built-in rules

build: ${TARBALL}
	tar -x --strip-components 1 -f ${TARBALL}
	sudo docker build --tag=${IMAGE} .

push:
	sudo docker tag ${IMAGE} ${IMAGE}:${VERSION}
	sudo docker tag ${IMAGE} ${IMAGE}:${DATE}
	sudo docker push ${IMAGE}

${TARBALL}:
	wget https://github.com/bitly/statsdaemon/releases/download/v${VERSION}/${TARBALL}

clean:
	rm -f ${TARBALL} ${NAME}

.PHONY: build push clean
