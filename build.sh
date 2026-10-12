#!/usr/bin/env bash
# =============================================================
#  build.sh - Build the XUPT journal LaTeX template (Linux/macOS)
#  Engine: XeLaTeX (required for ctex / fontspec)
#  Compiles twice to resolve cross-references, then removes
#  auxiliary files.
#
#  NOTE: On Linux you need CJK fonts installed (SimSun/SimHei/
#  KaiTi/FangSong are referenced by fontset=windows). Without
#  them, install a Chinese font and adjust fontset in xupt.cls.
# =============================================================
set -euo pipefail

MAIN="main"
ENGINE="xelatex"

echo "[1/2] First compile..."
"$ENGINE" -interaction=nonstopmode -halt-on-error "$MAIN.tex"

echo "[2/2] Second compile (resolve cross-references)..."
"$ENGINE" -interaction=nonstopmode -halt-on-error "$MAIN.tex"

echo "Cleaning auxiliary files..."
rm -f \
  "$MAIN.aux" "$MAIN.log" "$MAIN.out" "$MAIN.toc" "$MAIN.lof" "$MAIN.lot" \
  "$MAIN.bbl" "$MAIN.blg" "$MAIN.synctex.gz" "$MAIN.fls" "$MAIN.fdb_latexmk"

echo "Done: $MAIN.pdf"
