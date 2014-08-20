all: 388A.out 388B.out 388C.out 388D.out 388E.out 388F.out \
    388G.out 388H.out README.html
%.out: %.R
	R --no-save < $< > $@
README.html: README.md
	#-R -e 'library(knitr); knit("README.Rmd")'
	-pandoc README.md > README.html
clean:
	-rm *.out *.pdf *~ *swp README.html
view:
	-open *.pdf
