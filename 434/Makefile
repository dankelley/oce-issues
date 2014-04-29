all: 434.out 434B.out
%.out:%.R
	R --no-save < $< >& $@
clean:
	-rm *.out *~ *.png
view:
	-open *.png

