all: 432.out 432B.out
%.out:%.R
	R --no-save < $< >& $@
clean:
	-rm *.out *~ *.png
view:
	-open *.png

