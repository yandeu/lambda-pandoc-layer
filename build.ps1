#!/bin/pwsh

if (Test-Path layer) {
  Remove-Item layer -force -recurse
}

docker image build -t pandoc-layer .

docker run --rm -v $PWD/layer/:/tmp/layer pandoc-layer

Get-ChildItem layer