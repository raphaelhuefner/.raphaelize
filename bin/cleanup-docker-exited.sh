#!/bin/bash

# for filter types, @see https://docs.docker.com/engine/reference/commandline/ps/#filtering

docker container rm `docker container ls --filter status=exited -q`
