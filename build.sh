#!/bin/bash

rm -rf layer

docker image build -t pandoc-layer .

docker run --rm -v $PWD/layer/:/tmp/layer pandoc-layer

ls layer