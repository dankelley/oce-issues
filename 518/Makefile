all: 518A.out 518B.out 518C.out 518D.out 518E.out
%.out: %.R
	-R --no-save < $< > $@
clean: force
	-rm *~ *.png Rplots.pdf *.out
view: force
	-open *png
force:

