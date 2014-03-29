onepanel: oce415A.out oce415B.out oce415C.out oce415D.out
twopanel: oce415AA.out
all: onepanel twopanel
%.out: %.R
	R --no-save < $< > $@
clean:
	-rm *.out *.pdf *~ *swp

