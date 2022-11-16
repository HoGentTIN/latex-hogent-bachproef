from debian:bullseye

RUN apt update && apt-get install -y \
    texlive-latex-base \
    texlive-latex-extra \
    texlive-lang-european \
    texlive-bibtex-extra \
    biber \
    git \
    texstudio \
    jabref \
    r-base \
    texlive-xetex \
    python3-pip \
    latexmk \
    && rm -rf /var/lib/apt/lists/*

COPY fonts/ /usr/share/fonts/opentype
RUN fc-cache -f -v

RUN pip install pygments
