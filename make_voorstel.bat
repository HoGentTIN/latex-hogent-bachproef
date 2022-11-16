@REM utility batch file to render the tex file to a pdf

@REM build the docker image with all tex dependencies
docker build -t bpimg -f docker/Dockerfile .

@REM build the proposal
docker run --rm -v %cd%:/bp bpimg env /bp/docker/render_thesis.sh voorstel *BPvoorstel.tex

@REM keep window open after run
pause