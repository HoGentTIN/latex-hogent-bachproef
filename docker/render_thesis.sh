#!/bin/bash

cd /bp/$1
# latexmk -output-directory=../output -xelatex -synctex=1 -interaction=nonstopmode -file-line-error -shell-escape *BP.tex
latexmk -output-directory=../output -xelatex -synctex=1 -interaction=nonstopmode -file-line-error -shell-escape $2