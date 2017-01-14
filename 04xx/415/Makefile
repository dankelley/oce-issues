onepanel: 415A.out 415B.out 415C.out 415D.out
twopanel: 415AA.out
all: onepanel twopanel
%.out: %.R
	R --no-save < $< > $@
clean:
	-rm *.out *.pdf *.png *~ *swp
view:
	-open *.png
	-open *.pdf
