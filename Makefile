%.pdf: %.tex $(wildcard *.tex) $(addsuffix .dot.tex,$(basename $(wildcard *.dot)))
	xelatex $<
	xelatex $<

all: main.pdf

open: main.pdf
	xdg-open $<

DOT2TEXFLAGS=--figonly --format=tikz

%.dot.tex: %.dot
	dot2tex $(DOT2TEXFLAGS) --output=$@ $<

clean:
	$(RM) *.ps *.pdf *.aux *.log *.toc *.nav *.snm *.out *.dot.tex

.PHONY: open clean
