all: 452.out
%.out:%.R
	R --no-save < $< > $@
clean:
	-rm *.out *.png *~ *.pdf
view:
	-open *.pdf
	-open *.png

