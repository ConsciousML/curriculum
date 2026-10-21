# resume

My resume, written in LaTeX with [moderncv](https://ctan.org/pkg/moderncv). The source is `resume.tex`.

## Installation

Install [TeX Live](https://www.tug.org/texlive/) 2022, which provides `pdflatex`, from the [historic archive](https://www.tug.org/historic/). These steps work on macOS and Linux and install into `~/texlive/2022` without sudo.

1. Download the installer:

   ```sh
   REPO=https://ftp.math.utah.edu/pub/tex/historic/systems/texlive/2022/tlnet-final
   mkdir -p /tmp/tl && cd /tmp/tl
   curl -sfL $REPO/install-tl-unx.tar.gz | tar xz
   ```

2. Write an install profile (basic scheme, no docs or sources, shell config left untouched):

   ```sh
   cat > texlive.profile <<EOF
   selected_scheme scheme-basic
   TEXDIR $HOME/texlive/2022
   TEXMFLOCAL $HOME/texlive/texmf-local
   TEXMFSYSVAR $HOME/texlive/2022/texmf-var
   TEXMFSYSCONFIG $HOME/texlive/2022/texmf-config
   TEXMFHOME \$HOME/texmf
   tlpdbopt_install_docfiles 0
   tlpdbopt_install_srcfiles 0
   instopt_adjustpath 0
   EOF
   ```

3. Install TeX Live:

   ```sh
   perl install-tl-*/install-tl -profile texlive.profile -repository $REPO
   ```

4. Add it to your `PATH` (put this line in your shell config to keep it):

   ```sh
   export PATH=$(echo ~/texlive/2022/bin/*):$PATH
   ```

5. Install the packages the resume uses:

   ```sh
   tlmgr install moderncv fontawesome5 fancybox tcolorbox pgf eso-pic environ \
     multirow arydshln tikzfill pdfcol
   ```

## Build

```sh
mkdir -p build
pdflatex -output-directory build resume.tex
```

The PDF is written to `build/resume.pdf`.

## Workflow

`main` is protected, so every change goes through a pull request:

1. Edit `resume.tex` on a branch.
2. Build the PDF locally to check it.
3. Open a PR to `main`. CI checks that the resume compiles.
