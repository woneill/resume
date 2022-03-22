# Configuration
# --------------------------------------------------

LATEX = docker run --rm --user $(id -u):$(id -g) -i -w "/doc" -v $(abspath $(@D)):/doc thomasweise/texlive xelatex
LATEX_OPTIONS = 

RESUME_DIR = resume
RESUME_SRCS = $(shell find $(RESUME_DIR) -name '*.tex')

PDF2PNG = docker run --rm -v $(abspath $<):/var/workdir/input.pdf -v $(abspath $(@D)):/var/workdir/output/ kolyadin/pdf2img -png -q input.pdf output/$(<:.pdf=)

# Targets
# --------------------------------------------------

.PHONY: all
all: WilliamONeill.pdf WilliamONeill_coverletter.pdf WilliamONeill-1.png WilliamONeill-2.png

WilliamONeill%.png: WilliamONeill.pdf
	$(PDF2PNG)

WilliamONeill.pdf: WilliamONeill.tex $(RESUME_DIR) $(RESUME_SRCS)
	$(LATEX) $(LATEX_OPTIONS) $<

WilliamONeill_coverletter.pdf: WilliamONeill_coverletter.tex
	$(LATEX) $(LATEX_OPTIONS) $< 

$(RESUME_DIR):
	mkdir $(RESUME_DIR)

clean:
	rm -rf *.pdf *.png *.aux *.fls *.log *.out *.fdb_latexmk *.synctex.gz
