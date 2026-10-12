@echo off
rem =============================================================
rem  build.bat - Build the XUPT journal LaTeX template (Windows)
rem  Engine: XeLaTeX (required for ctex / fontspec)
rem  Compiles twice to resolve cross-references, then removes
rem  auxiliary files.
rem =============================================================
setlocal

set "MAIN=main"
set "ENGINE=xelatex"

echo [1/2] First compile...
%ENGINE% -interaction=nonstopmode -halt-on-error "%MAIN%.tex"
if errorlevel 1 goto :fail

echo [2/2] Second compile (resolve cross-references)...
%ENGINE% -interaction=nonstopmode -halt-on-error "%MAIN%.tex"
if errorlevel 1 goto :fail

echo Cleaning auxiliary files...
del /q "%MAIN%.aux" "%MAIN%.log" "%MAIN%.out" "%MAIN%.toc" "%MAIN%.lof" "%MAIN%.lot" "%MAIN%.bbl" "%MAIN%.blg" "%MAIN%.synctex.gz" "%MAIN%.fls" "%MAIN%.fdb_latexmk" 2>nul

echo Done: %MAIN%.pdf
exit /b 0

:fail
echo Compilation failed. Check "%MAIN%.log" for details.
exit /b 1
