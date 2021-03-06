#!/bin/sh

# If a command fails then the deploy stops
set -e

printf "\033[0;32mCompile and push pdf to GitHub...\033[0m\n"

pdflatex main.tex

# Add changes to git.
git add -u

# Commit changes.
msg="rebuilding site $(date)"
if [ -n "$*" ]; then
	msg="$*"
fi
git commit -m "$msg"

# Push source and build repos.
git push origin master
