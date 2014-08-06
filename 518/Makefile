all: 01.out 02.out 03.out
%.out: %.R
	-R --no-save < $< > $@
clean: force
	-rm *~ *.png Rplots.pdf *.out
view: force
	-open *png
force:

