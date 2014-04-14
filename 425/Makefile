all: 425.out
%.out:%.R
	R --no-save < $< > $@
clean:
	-rm *.out *.png *~
view:
	open 425.png

