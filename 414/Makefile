all: oce414.out
%.out: %.R
	R --no-save < $< > $@
clean:
	-rm *.out *.pdf *~ *swp

