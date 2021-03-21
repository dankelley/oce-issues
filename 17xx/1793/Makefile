all: $(patsubst %.R,%.out,$(wildcard *.R))
%.out: %.R
	R --no-save < $< &> $@
clean:
	-rm *~ *png *.out
view:
	open *.png

