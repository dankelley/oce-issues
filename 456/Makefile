all: 456a.out
%.out: %.R
	-R --no-save < $< > $@ 2>&1
clean:
	-rm *~ *.out
view:
	-open *.png
	-open *.pdf


