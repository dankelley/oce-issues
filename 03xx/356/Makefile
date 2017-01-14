all: 356A.out 356B.out 356C.out
%.out: %.R
	R --no-save < $< > $@
clean:
	-rm *.out *.png *~ *swp
view:
	-open *.png
