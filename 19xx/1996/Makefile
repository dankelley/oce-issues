all: $(patsubst %.R,%.out,$(wildcard *.R))
%.out: %.R
	R --no-save < $< >& $@
clean: force
	rm *~ *out
force:

