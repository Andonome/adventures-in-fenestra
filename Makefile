filename=main
branch := $(shell git rev-parse --abbrev-ref HEAD)
output: ${filename}.pdf 
	pdflatex ${filename}.tex

main.pdf: svg-inkscape
	makeindex ${filename}.idx
	makeglossaries ${filename}
	pdflatex ${filename}.tex
svg-inkscape:
	pdflatex -shell-escape ${filename}.tex
tree:
	[ -e ../config ] || ( echo "You don't have a local config repo" && exit 1 )
	git status
	git subtree -P config pull ../config ${branch}
	git subtree -P config push ../config ${branch}
clean:
	rm -rf *.aux *.toc *.acn *.log *.ptc *.out *.idx *.ist *.glo *.glg *.gls *.acr *.alg *.ilg *.ind *.pdf svg-inkscape
