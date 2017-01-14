all: 390A.out
%.out: %.R
	R --no-save < $< > $@
clean:
	-rm *.out *.png *.pdf *~ *swp
view:
	-open *.png


