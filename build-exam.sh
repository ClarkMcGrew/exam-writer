#!/bin/bash
#
# Take an exam base name and build all of the exam and solution files.
# The input files should be in the current directory, and the output
# files will be written to the current directory.  This takes one
# argument which is the exam base name
#
# Example:
#
#   build-exam.sh aSampleBaseName
#

for file in ${1}-????.tex; do
    base=$(echo ${file} | sed s:.tex::)
    pdf="${base}.pdf"
    soln="${base}-soln.pdf"
    pdflatex -halt-on-error "\def\printSolutions{}\input{${file}}" && \
        pdflatex "\def\printSolutions{}\input{${file}}" && \
        mv ${pdf} ${soln} && \
        rm *.aux *.log
    pdflatex -halt-on-error "${file}" && \
        pdflatex "${file}" && \
        rm *.aux *.log
done
            
