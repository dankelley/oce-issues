all: 426.out 426test.out
%.out:%.R
	R --no-save < $< > $@
clean:
	-rm *.out *.png *~
view:
	open *.png

