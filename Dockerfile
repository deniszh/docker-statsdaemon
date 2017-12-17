FROM golang:1.9-alpine

RUN apk update && apk add git curl
RUN git clone https://github.com/bitly/statsdaemon.git /home/statsdaemon
RUN cd /home/statsdaemon && CGO_ENABLED=0 go build -ldflags="-s -w"

FROM busybox

EXPOSE 8125/udp
ENV ADDRESS  127.0.0.1:8125
ENV GRAPHITE 127.0.0.1:2003
ENV FLUSH_INTERVAL 60
ENV PERCENTILES    90,99
#ENV PREFIX (blank)

COPY --from=0 /home/statsdaemon/statsdaemon /usr/local/bin/

CMD exec statsdaemon --address=$ADDRESS               \
                     --graphite=$GRAPHITE             \
                     --prefix=$PREFIX                 \
                     --flush-interval=$FLUSH_INTERVAL \
         $(echo $PERCENTILES | tr , '\n' | xargs printf -- '--percent-threshold=%s ')
