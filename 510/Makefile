all: 510.out
%.out: %.R
	R --no-save < $< > $@
clean:
	-rm *.out *swp
view:
	echo "nothing to view in 510; lack of error proves success"
