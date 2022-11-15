from debian:bullseye

RUN apt update
RUN apt install -y texlive-latex-base texlive-latex-extra texlive-lang-european texlive-bibtex-extra biber
RUN apt install -y git texstudio jabref r-base
RUN apt install -y texlive-xetex

COPY fonts/ /usr/share/fonts/opentype

RUN fc-cache -f -v

RUN apt install -y python3-pip
RUN apt install -y latexmk
RUN pip install pygments
