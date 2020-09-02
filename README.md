# Papers

Selected CI/CD articles published by Semaphore.

## Production

![Semaphore build](https://semaphore-oss.semaphoreci.com/badges/papers.svg)

Content is written in Markdown, final PDF made with [Pandoc][pandoc].

We're using official [Docker images of Pandoc][pandoc-docker].
You need to have Docker installed to build the PDF. See `Makefile`.

Semaphore automatically creates and uploads the PDF as an artifact from the
latest version of source text. See [project on Semaphore][semaphore-project].

## How to add a paper

1. Copy the original source file in markdown and related images into the `papers/` folder.
Any images should be relative to this folder.
2. Append the contents of `footer.md` to the markdown file:

        cat footer.md >> papers/MY-AWESOME-PAPER.md

3. Edit the markdown file. Fill in publication values in the footer (YOUR ORIGINAL PUB URL, etc). You may need to add a title at the beginning. Check everything looks OK:

        $EDITOR papers/MY-AWESOME-PAPER.md

3. Edit `Makefile` and add the new filename *without the extension or path* to the list in `PAPERS`:

        PAPERS = paper-1 paper-2 ... MY-AWESOME-PAPER

4. Build all the PDFs: `make pdf`
5. Output PDF is in: `build/pdf/MY-AWESOME-PAPER.pdf`

## Contributing

Feel free to contribute to the quality of these papers by opening issues or
submitting PRs for improvements to explanations, code snippets, etc.

## Copyright & License

Copyright © 2020 Rendered Text.

This work is licensed under CC BY-NC-ND 4.0 <a href="https://creativecommons.org/licenses/by-nc-nd/4.0"><img height="16" style="margin-left: 3px;vertical-align:text-bottom;" src="https://search.creativecommons.org/static/img/cc_icon.svg" /><img height="16" style="margin-left: 3px;vertical-align:text-bottom;" src="https://search.creativecommons.org/static/img/cc-by_icon.svg" /><img height="16" style="margin-left: 3px;vertical-align:text-bottom;" src="https://search.creativecommons.org/static/img/cc-nc_icon.svg" /><img height="16" style="important;margin-left: 3px;vertical-align:text-bottom;" src="https://search.creativecommons.org/static/img/cc-nd_icon.svg" /></a>

[pandoc]: https://pandoc.org
[pandoc-docker]: https://github.com/pandoc/dockerfiles
[semaphore-project]: https://semaphore-oss.semaphoreci.com/projects/papers
