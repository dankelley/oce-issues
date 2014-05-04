all: 435.out 435B.out
%.out:%.R
	R --no-save < $< > $@
clean:
	-rm *.out *.png *~ *.pdf
view:
	-open *.png

