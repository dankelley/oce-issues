all: 388A.out 388B.out 388C.out 388D.out 388E.out 388F.out \
    388G.out 388H.out 388I.out 388J.out 388K.out README.pdf
%.out: %.R
	R --no-save < $< > $@
README.pdf: README.md
	#-R -e 'library(knitr); knit("README.Rmd")'
	-pandoc -V geometry:margin=0.7in README.md -o README.pdf
	
clean:
	-rm *.out *.png *.pdf *~ *swp README.html
view:
	-open README.pdf

