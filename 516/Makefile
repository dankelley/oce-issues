all: 516A.out 516B.out 516C.out
%.out: %.R
	R --no-save < $< > $@
clean:
	-rm *~ *.png *.out *swp
view:
	-open *.png
