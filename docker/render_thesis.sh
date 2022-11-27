#!/bin/bash

set -o errexit
set -o nounset

readonly source_dir="${1}"
readonly latex_file="${2}"

readonly output_dir="../output"

cd "/bp/${source_dir}"

latexmk \
  -file-line-error \
  -interaction=nonstopmode \
  -output-directory="${output_dir}" \
  -shell-escape \
  -synctex=1 \
  -xelatex \
  "${latex_file}"