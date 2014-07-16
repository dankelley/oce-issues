all: 424.out README.html
%.out:%.R
	R --no-save < $< > $@
README.md: README.Rmd
	R -e 'library(knitr); knit("README.Rmd")'
view:
	-open *.png
clean:
	-rm *~ *.pdf *.png *.out README.html README.md

