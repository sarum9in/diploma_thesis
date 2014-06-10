%.pdf: %.tex $(wildcard *.tex) $(addsuffix .dot.tex,$(basename $(wildcard *.dot))) $(addsuffix .eps,$(basename $(wildcard *.msc)))
	xelatex $<
	xelatex $<

all: main.pdf presentation.pdf

open: main.pdf
	xdg-open $<

DOT2TEXFLAGS=--figonly --format=tikz

%.dot.tex: %.dot
	dot2tex $(DOT2TEXFLAGS) --output=$@ $<

%.eps: %.msc
	mscgen -T eps -o $@ -i $<

clean:
	$(RM) *.ps *.pdf *.aux *.log *.toc *.nav *.snm *.out *.dot.tex

.PHONY: open clean
