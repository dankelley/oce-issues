all: 388A.out 388B.out 388C.out 388D.out 388E.out README.html
%.out: %.R
	R --no-save < $< > $@
README.html: README.Rmd
	-R -e 'library(knitr); knit("README.Rmd")'
	-pandoc README.md > README.html
clean:
	-rm *.out *.pdf *~ *swp README.html
view:
	-open *.pdf
