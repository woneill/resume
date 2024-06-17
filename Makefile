# Configuration
# --------------------------------------------------

ifndef CI
	TEXLIVE_DOCKER = docker run --rm -w "/doc" -v $(abspath $(@D)):/doc texlive/texlive
endif

RESUME_SRCS = $(wildcard resume/*.tex)


# Targets
# --------------------------------------------------

.PHONY: all
all: WilliamONeill.pdf WilliamONeill_coverletter.pdf WilliamONeill-1.svg WilliamONeill-2.svg

WilliamONeill.xdv: WilliamONeill.tex $(RESUME_SRCS)
	@$(TEXLIVE_DOCKER) xelatex -interaction=batchmode  -halt-on-error -no-pdf $<

WilliamONeill%.svg: WilliamONeill.xdv
	@$(TEXLIVE_DOCKER) dvisvgm --bbox=letter --font-format=woff2 --page=-2 $<

WilliamONeill.pdf: WilliamONeill.xdv
	@$(TEXLIVE_DOCKER) xdvipdfmx $<

WilliamONeill_coverletter.pdf: WilliamONeill_coverletter.tex
	@$(TEXLIVE_DOCKER) xelatex $< 

clean:
	rm -rf *.xdv *.pdf *.png *.svg *.aux *.fls *.log *.out *.fdb_latexmk *.synctex.gz
