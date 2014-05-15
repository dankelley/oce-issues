all: 448.out
%.out: %.R
	R --no-save < $< > $@
clean:
	-rm -f *~ *.out
view:
	-open *png

