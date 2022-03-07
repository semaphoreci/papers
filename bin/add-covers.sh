#!/bin/bash
# Postprocess PDF to add cover page. This script overwrites the original PDFs.
# Usage: add-covers.sh cover_dir source_dir

set -e

COVER_DIR=$1
SOURCE_DIR=$2

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
CPDF="${SCRIPT_DIR}/cpdf"
TMP_DIR=$(mktemp -d)

for cover in "$COVER_DIR/"*.pdf; do
    fn=$(basename "$cover")
    echo -n "Found cover $fn ..."
    if [ -f "$SOURCE_DIR/$fn" ]; then
        echo "adding cover to source PDF."
        $CPDF "$cover" "$SOURCE_DIR/$fn" -o "$TMP_DIR/$fn"
    else
        echo "no source PDF found. Skipping this cover."
    fi
done

mv -f "$TMP_DIR"/*.pdf "$SOURCE_DIR"
rmdir "$TMP_DIR"
