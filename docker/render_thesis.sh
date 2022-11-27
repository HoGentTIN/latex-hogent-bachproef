#!/bin/bash

set -o errexit
set -o nounset

readonly source_dir="${1}"
readonly output_dir="../output"

# Enable debug output for troubleshooting purposes
set -x

cd "/bp/${source_dir}"

# Find all main .tex files (containing the \documentclass command)
source_files=$(grep --files-with-match '\\documentclass' ./*.tex)

set +x

# Loop over all found .tex source files and compile
for latex_file in ${source_files}; do
  echo "========== Compiling ${latex_file} =========="
  set -x
  latexmk \
    -file-line-error \
    -interaction=nonstopmode \
    -output-directory="${output_dir}" \
    -shell-escape \
    -synctex=1 \
    -xelatex \
    "${latex_file}"
  set +x
done