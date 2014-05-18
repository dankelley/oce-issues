all: 454.out 454b.out
%.out:%.R
	R --no-save < $< > $@
clean:
	-rm *.out *.png *~ *.pdf
view:
	-open *.pdf
	-open *.png

