all: 432.out 432B.out 432C.out
%.out:%.R
	R --no-save < $< >& $@
clean:
	-rm *.out *~ *.png
view:
	-open *.png

