BUILDDIR = build
PAPERDIR = papers
PAPERS = what-is-blue-green-deployment

.PHONY: clean

clean:
	rm -r $(BUILDDIR)

# works with 1 
pdf: $(BUILDDIR)/pdf/$(PAPERS).pdf
txt: $(BUILDDIR)/txt/$(PAPERS).txt

$(BUILDDIR)/pdf/$(PAPERS).pdf: $(PAPERDIR)/$(PAPERS).md
	mkdir -p $(BUILDDIR)/pdf
	docker run --rm --volume `pwd`:/data -w /data pandoc/latex:2.6 -f markdown-implicit_figures -V geometry:margin=1.5in --resource-path=$(PAPERDIR) -o /data/$@ $^

# make-code-small breaks papers that don't include code fences
# $(BUILDDIR)/pdf/$(PAPERS).pdf: $(PAPERDIR)/$(PAPERS).md
# 	mkdir -p $(BUILDDIR)/pdf
# 	docker run --rm --volume `pwd`:/data -w /data pandoc/latex:2.6 -f markdown-implicit_figures -H make-code-small.tex -V geometry:margin=1.5in --resource-path=$(PAPERDIR) -o /data/$@ $^

$(BUILDDIR)/txt/$(PAPERS).txt: $(PAPERDIR)/$(PAPERS).md
	mkdir -p $(BUILDDIR)/txt
	docker run --rm -it --volume `pwd`:/data -w /data ubuntu bash

# $@ build/txt/bluegreen-general.txt 
# $^ papers/bluegreen-general.md



