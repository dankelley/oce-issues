all: 388A.out 388B.out 388C.out
%.out: %.R
	R --no-save < $< > $@
clean:
	-rm *.out *.pdf *~ *swp
view:
	-open *.pdf
