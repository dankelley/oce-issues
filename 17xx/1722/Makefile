all: $(patsubst %.R,%.out,$(wildcard *.R))
%.out: %.R
	R --no-save < $< &> $@
clean:
	-rm *.out *~ *png
view:
	open *.png

