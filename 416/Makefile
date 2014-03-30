all: 416A.out 416B.out 416C.out 416layout.out 416layout2.out
%.out: %.R
	R --no-save < $< > $@
clean:
	-rm *.out *.pdf *.png *~ *swp
view:
	-open *.png
	-open *.pdf
