all: 531.out 531B.out
%.out: %.R
	R --no-save < $< > $@
clean:
	-rm *.out *.png *~ *swp
view:
	-open *.png
