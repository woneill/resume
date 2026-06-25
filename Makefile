# Configuration
# --------------------------------------------------

ifndef CI
	TEXLIVE_DOCKER = docker run --rm -w "/doc" -v $(abspath $(@D)):/doc texlive/texlive
	POPPLER_DOCKER = docker run --rm -w "/doc" -v $(abspath $(@D)):/doc minidocks/poppler
endif

RESUME_SRCS = $(wildcard resume/*.tex)


# Targets
# --------------------------------------------------

.PHONY: all
all: WilliamONeill.pdf WilliamONeill_coverletter.pdf WilliamONeill-1.svg WilliamONeill-2.svg

WilliamONeill.pdf: WilliamONeill.tex $(RESUME_SRCS)
	@$(TEXLIVE_DOCKER) lualatex -interaction=batchmode -halt-on-error $<

WilliamONeill-%.svg: WilliamONeill.pdf
	@$(POPPLER_DOCKER) pdftocairo -svg -f $* -l $* $< $@

WilliamONeill_coverletter.pdf: WilliamONeill_coverletter.tex
	@$(TEXLIVE_DOCKER) lualatex $<

clean:
	rm -rf *.pdf *.png *.svg *.aux *.fls *.log *.out *.fdb_latexmk *.synctex.gz
