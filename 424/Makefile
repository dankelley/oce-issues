all: 424.out README.html
%.out:%.R
	R --no-save < $< > $@
README.html: README.md
	pandoc $< > $@
README.md: README.Rmd
	R -e 'library(knitr); knit("README.Rmd")'

view:
	-open *.png
	-open *.pdf
clean:
	-rm *~ *.pdf *.png *.out README.html README.md

