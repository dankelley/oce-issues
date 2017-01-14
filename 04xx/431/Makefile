all: 431A.out 431B.out 431C.out
%.out:%.R
	R --no-save < $< > $@
clean:
	-rm *.out *~ *.png
view:
	-open *.png

