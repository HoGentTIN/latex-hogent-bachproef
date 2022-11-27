#!/bin/bash
# utility batch file to render the tex file to a pdf

set -o nounset
set -o errexit

# If Podman is installed (Fedora), use that instead of Docker
if [ -x /usr/bin/podman ]; then
  echo "Detected Podman"
  container_cmd=/usr/bin/podman
  # Without this mount option, the container will not have access to the
  # shared volume /bp
  mount_opts=":Z"
else
  echo "Using Docker"
  container_cmd=/usr/bin/docker
  mount_opts=
fi

# build the docker image with all tex dependencies
${container_cmd} build --tag bpimg \
  --file docker/Dockerfile .

# build the proposal
${container_cmd} run --rm \
  --volume "$PWD":/bp"${mount_opts}" bpimg \
  sh /bp/docker/render_thesis.sh voorstel
