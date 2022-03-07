#!/bin/bash
# Postprocess PDF to add cover page. This script overwrites the original PDFs.
# Usage: add-covers.sh cover_dir source_dir

COVER_DIR=$1
SOURCE_DIR=$2

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
CPDF="${SCRIPT_DIR}/cpdf"
TMP_DIR=$(mktemp -d)

echo "script path is $SCRIPT_DIR"

for cover in "$COVER_DIR/"*.pdf; do
    echo "Adding cover $cover"
    $CPDF "$cover" "$SOURCE_DIR/$cover" -o "$TMP_DIR"
done

mv "$TMP_DIR" "$SOURCE_DIR"
rmdir "$TMP_DIR"
