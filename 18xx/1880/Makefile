all: $(patsubst %.R,%.out,$(wildcard 1*.R))
%.out: %.R
	R --no-save < $< &> $@
clean:
	-rm *~ *png *.out *pdf
view:
	open *.png

