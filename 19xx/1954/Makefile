all: $(patsubst %.R,%.out,$(wildcard *.R))
%.out: %.R
	-Rscript $< >& $@
clean: force
	rm *~ *out
force:

