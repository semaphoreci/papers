# Add your markdown sources here
# (do not include path or file extension)
PAPERS = what-is-blue-green-deployment cicd-pipeline-a-gentle-introduction \
		 cicd-continuous-integration-and-delivery-explained

PAPERDIR = papers
BUILDDIR = build
export YEAR = $(shell date +'%Y')
export MONTH = $(shell date +'%b')
export REVISION = $(shell git rev-parse --short HEAD)

.PHONY: pdf clean

# `make pdf` target for all PDFs generated in $(PAPERS)
pdf: $(addprefix build/pdf/,$(addsuffix .pdf,$(PAPERS)))

clean:
	rm -rf $(BUILDDIR)

# builds intermediate markdown file with __BUILD_* variables interpolated
$(BUILDDIR)/md/%.md: $(PAPERDIR)/%.md
	mkdir -p $(BUILDDIR)/md
	sed -e "s/__BUILD_MONTH__/${MONTH}/g;s/__BUILD_YEAR__/${YEAR}/g;s/__BUILD_REVISION__/${REVISION}/g" $< > $@

# builds PDF using pandoc and docker
$(BUILDDIR)/pdf/%.pdf: $(BUILDDIR)/md/%.md
	mkdir -p $(BUILDDIR)/pdf
	docker run --rm --volume `pwd`:/data -w /data pandoc/latex:2.10 \
		--pdf-engine=xelatex \
        -f markdown \
		-d pdf-options.yml \
		-H make-code-small.tex \
		--resource-path=$(PAPERDIR) \
		-o /data/$@ $^

