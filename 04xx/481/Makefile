all: 481A.out 481B.out
%.out: %.R
	R --no-save < $< > $@
clean:
	-rm *.out *.png *~ *swp
view:
	-open *.png
