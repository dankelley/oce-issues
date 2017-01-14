all: 489A.out
%.out: %.R
	R --no-save < $< > $@
clean:
	-rm *.out *.png *~ *swp
view:
	-open *.png
