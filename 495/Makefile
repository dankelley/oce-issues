all: 495A.out 495B.out
%.out: %.R
	R --no-save < $< > $@
clean:
	-rm *.out *.pdf *.png *~ *swp
view:
	-open *.png
