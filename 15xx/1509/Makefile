all: 1509a.out

%.out: %.R
	R --no-save < $< > $@

clean:
	-rm *.out *.png *.pdf
