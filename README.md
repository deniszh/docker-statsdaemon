# statsdaemon docker image

Tiny image (8.8 MiB), based on busybox,
for running [statsdaemon](https://github.com/bitly/statsdaemon).

Control with container environment variables (`--env=...`):

  - `ADDRESS` default 127.0.0.1:8125
  - `GRAPHITE` default 127.0.0.1:2003
  - `FLUSH_INTERVAL` default 60 (seconds)
  - `PREFIX` default none
  - `PERCENTILES` default 90,99

(As you can see, I prefer to not set up container "links", instead using `--net=host`.)

See the Dockerfile at https://github.com/ploxiln/docker-statsdaemon
Built images are on Docker Hub at https://registry.hub.docker.com/u/ploxiln/statsdaemon/
