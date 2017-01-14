all: 458a.out 458b.out
%.out: %.R
	-R --no-save < $< > $@ 2>&1
clean:
	-rm *~ *.out
view:
	-open *.png
	-open *.pdf


