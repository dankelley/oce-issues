all: 478.out
%.out:%.R
	R --no-save < $< > $@
%.html:%.md
	pandoc $< > $@
clean:
	-rm *.out *.png
view:
	-open *.png

