all: 524-1.out
%.out: %.R
	R --slave < $< > $@
clean:
	-rm *.out *.png *.pdf *~ *swp README.html
view:
	echo "nothing to view in 524"

