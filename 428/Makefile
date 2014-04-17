all: 428.out
%.out:%.R
	R --no-save < $< > $@
clean:
	-rm *.out *.png *~
view:
	open *.png

