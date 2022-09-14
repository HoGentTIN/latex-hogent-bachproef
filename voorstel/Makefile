## Makefile

##---------- Preliminaries ----------------------------------------------------
.POSIX:     # Get reliable POSIX behaviour
.SUFFIXES:  # Clear built-in inference rules
.PHONY: help clean mrproper install

##---------- Variables --------------------------------------------------------

# Select .tex files that contain "\documentclass"
sources := $(shell grep --files-with-matches '\\documentclass' *.tex)
# Derive the names of all resulting PDF files
pdfs := $(patsubst %.tex,%.pdf,$(sources))
# Output directory for intermediate and resulting files
output_dir := out

# LaTeX command for compiling the .tex files:
latex_cmd := latexmk -output-directory="$(output_dir)" -xelatex -synctex=1 -interaction=nonstopmode -file-line-error -shell-escape

##---------- Build targets ----------------------------------------------------

help: ## Show this help message (default)
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)
	@printf "To generate a specific PDF: make NAME.pdf\n"
	@printf "With NAME one of the following file names:\n"
	@printf "\033[36m%s\033[0m\n" $(pdfs)

all: $(pdfs) ## Compile all LaTeX files (see list below)

%.pdf: %.tex
	[ -d $(output_dir) ] || mkdir -pv $(output_dir)
	$(latex_cmd) $<

clean: ## Delete LaTeX auxiliary files
	rm -vf "$(output_dir)"/*.{bak,aux,log,nav,out,snm,ptc,toc,bbl,blg,idx,ilg,ind,tcp,vrb,tps,lof,log,lol,lot,synctex.gz,fls,fdb_latexmk,bcf,run.xml,xdv}
	rm -vrf "$(output_dir)"/_minted*

mrproper: clean ## Delete LaTeX auxiliary files and PDFs
	rm -rf "$(output_dir)"/*.pdf
