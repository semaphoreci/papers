# papers
Selected CI/CD articles published by Semaphore.

## Adding a paper

1. Copy the markdown source and related images into the `papers/` folder.
2. Append the contents of `footer.md` to the paper markdown source:

    cat footer.md >> papers/MY-AWESOME-PAPER.md

3. Edit your markdown source. Check everything is OK. Fill in placeholder values in the footer:

    $EDITOR papers/MY-AWESOME-PAPER.md

3. Edit `Makefile` and add the paper filename *without the extension or path* to the list in the `PAPERS` variable:

    PAPERS = paper-1 paper-2 ... MY-AWESOME-PAPER

4. Build all the PDFs: `make pdf`

## Example

