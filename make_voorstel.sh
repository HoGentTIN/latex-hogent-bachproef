#!/bin/bash
# utility batch file to render the tex file to a pdf

# build the docker image with all tex dependencies
docker build -t bpimg -f docker/Dockerfile .

# build the proposal
docker run --rm -v "$PWD":/bp bpimg env /bp/docker/render_thesis.sh voorstel *BPvoorstel.tex
