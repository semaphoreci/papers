# Add your markdown sources here
# (do not include path or file extension)
PAPERS = what-is-blue-green-deployment \
		cicd-pipeline-a-gentle-introduction \
		cicd-continuous-integration-and-delivery-explained \
		continuous-blue-green-deployments-with-kubernetes \
		continuous-integration-explained \
		a-complete-guide-to-making-your-slow-tests-fast \
		canary-deployments \
		what-is-monorepo \
		stubbing-and-mocking-with-mockito \
		cicd-interview \
		testing-python-with-pytest \
		dockerizing-django \
		java-with-spock \
		a-first-look-at-bun \
		building-rest-api-go-and-mux

# PAPERS = stubbing-and-mocking-with-mockito \
# 		cicd-interview \
# 		testing-python-with-pytest \
# 		dockerizing-django

# PAPERS = 

PAPERDIR = papers
BUILDDIR = build
export YEAR = $(shell date +'%Y')
export MONTH = $(shell date +'%b')
export REVISION = $(shell git rev-parse --short HEAD)

# handle non-intel archs (eg. Apple M1)
EXTRA_OPTS =
ARCH = $(shell arch)
ifeq ($(ARCH),arm64)
	EXTRA_OPTS += --platform linux/amd64
endif


.PHONY: pdf clean

# `make pdf` target for all PDFs generated in $(PAPERS)
pdf: $(addprefix build/pdf/,$(addsuffix .pdf,$(PAPERS)))

clean:
	rm -rf $(BUILDDIR)

# builds intermediate markdown files with __BUILD_* variables interpolated
$(BUILDDIR)/md/%.md: $(PAPERDIR)/%.md
	mkdir -p $(BUILDDIR)/md
	sed -e "s/__BUILD_MONTH__/${MONTH}/g;s/__BUILD_YEAR__/${YEAR}/g;s/__BUILD_REVISION__/${REVISION}/g" $< > $@

# builds PDF using pandoc and docker
$(BUILDDIR)/pdf/%.pdf: $(BUILDDIR)/md/%.md
	mkdir -p $(BUILDDIR)/pdf
	docker run --rm $(EXTRA_OPTS) \
		--volume `pwd`:/data -w /data pandoc/latex:2.10 \
		--pdf-engine=xelatex \
		-f markdown+implicit_figures \
		-d pdf-options.yml \
		--resource-path=$(PAPERDIR) \
		-o /data/$@ $^

