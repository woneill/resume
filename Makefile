# Configuration
# --------------------------------------------------

LATEX = xelatex

RESUME_DIR = resume
RESUME_SRCS = $(shell find $(RESUME_DIR) -name '*.tex')

CV_DIR = cv
CV_SRCS = $(shell find $(CV_DIR) -name '*.tex')


# Targets
# --------------------------------------------------

.PHONY: all
all: resume.pdf coverletter.pdf #cv.pdf

resume.pdf: resume.tex $(RESUME_DIR) $(RESUME_SRCS)
	$(LATEX) $<

cv.pdf: cv.tex $(CV_DIR) $(CV_SRCS)
	$(LATEX) $<

coverletter.pdf: coverletter.tex
	$(LATEX) $<

$(RESUME_DIR):
	mkdir $(RESUME_DIR)

$(CV_DIR):
	mkdir $(CV_DIR)

clean:
	rm -rf *.pdf
