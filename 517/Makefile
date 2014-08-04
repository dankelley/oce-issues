all: 517A.out 
%.out: %.R
	R --no-save < $< > $@
clean:
	-rm *~ *.png *.out *swp
view:
	-open *.png
