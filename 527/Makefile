all: 527.out
%.out: %.R
	R --no-save < $< > $@
clean:
	-rm *.out *.pdf *.png *~ *swp
view:
	-open *.png
