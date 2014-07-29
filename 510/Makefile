all: 510A.out 510B.out 510C.out
%.out: %.R
	R --no-save < $< > $@
clean:
	-rm *.out *swp
view:
	echo "nothing to view in 510; lack of error proves success"
