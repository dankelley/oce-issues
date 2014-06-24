all: 475a.out 475b.out
%.out:%.R
	R --no-save < $< > $@
%.html:%.md
	pandoc $< > $@
clean:
	-rm *.out
view:
	-open *.png

