# A is CR test; B is DK test with lots of debugging
all: 514A.out 514B.out 514C.out
%.out: %.R
	R --no-save < $< > $@
clean:
	-rm *~ *.out *swp *.pdf *.png
view:
	open *png
