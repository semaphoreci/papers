# list of papers to build (without extension)
PAPERS = what-is-blue-green-deployment

PAPERDIR = papers
BUILDDIR = build
export YEAR = $(shell date +'%Y')
export MONTH = $(shell date +'%b')
export REVISION = $(shell git rev-parse --short HEAD)

.PHONY: clean pdf

clean:
	rm -r $(BUILDDIR)

# `make pdf` target for all PDFs generated in $(PAPERS)
pdf: $(addprefix build/pdf/,$(addsuffix .pdf,$(PAPERS)))

# builds intermediate markdown file with __BUILD_* variables interpolated
$(BUILDDIR)/md/%.md: $(PAPERDIR)/%.md
	mkdir -p $(BUILDDIR)/md
	sed -e "s/__BUILD_MONTH__/${MONTH}/g;s/__BUILD_YEAR__/${YEAR}/g;s/__BUILD_REVISION__/${REVISION}/g" $< > $@

# builds PDF using pandoc and docker
$(BUILDDIR)/pdf/%.pdf: $(BUILDDIR)/md/%.md
	mkdir -p $(BUILDDIR)/pdf
	docker run --rm --volume `pwd`:/data -w /data pandoc/latex:2.6 -f markdown-implicit_figures -V geometry:margin=1.5in --resource-path=$(PAPERDIR) -o /data/$@ $^
