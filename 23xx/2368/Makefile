all: $(patsubst %.R,%.out,$(wildcard *.R))
%.out: %.R
	Rscript $< &> $@
clean:
	-rm *~ *png *.out *pdf
view:
	open *.png

