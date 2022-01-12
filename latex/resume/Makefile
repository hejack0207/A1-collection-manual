SRC = $(wildcard *.tex)

PDFS = $(SRC:.tex=.pdf)

all: clean pdf

pdf: clean $(PDFS)

output:
	mkdir -p $@

%.pdf:  %.tex output
	xelatex -output-directory output $<

RM = rm -f

clean:
	cd output; $(RM) *.log *.aux *.bbl *.blg *.synctex.gz *.out *.toc *.lof *.idx *.ilg *.ind *.pdf
