all: 438.out
%.out:%.R
	R --no-save < $< > $@
clean:
	-rm *.out *.png *~ *.pdf
view:
	-open *.png

