all: oce413.out
%.out: %.R
	R --no-save < $< > $@
clean:
	-rm *.out *.pdf *,png *~ *swp

