all: 477a.out 477b.out
%.out:%.R
	R --no-save < $< > $@
%.html:%.md
	pandoc $< > $@
clean:
	-rm *.out *.png
view:
	-open *.png

