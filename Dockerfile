FROM busybox:ubuntu-14.04
MAINTAINER Pierce Lopez <pierce.lopez@gmail.com>

EXPOSE 8125/udp

ENV ADDRESS  127.0.0.1:8125
ENV GRAPHITE 127.0.0.1:2003
ENV FLUSH_INTERVAL 60
ENV PERCENTILES    90,99
#ENV PREFIX (blank)

COPY statsdaemon /bin/

CMD exec /bin/statsdaemon --address=$ADDRESS               \
                          --graphite=$GRAPHITE             \
                          --prefix=$PREFIX                 \
                          --flush-interval=$FLUSH_INTERVAL \
         $(echo $PERCENTILES | tr , '\n' | xargs printf -- '--percent-threshold=%s ')
