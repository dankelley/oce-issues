all: 456a.out 456b.out 456c.out
%.out: %.R
	-R --no-save < $< > $@ 2>&1
clean:
	-rm *~ *.out 456*.pdf
view:
	-open *.pdf


