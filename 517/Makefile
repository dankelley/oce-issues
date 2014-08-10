all: 517A.out 517Adk.out
%.out: %.R
	R --no-save < $< > $@
clean:
	-rm *~ *.png *.out *swp
view:
	-open *.png
