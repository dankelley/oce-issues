all: 465a.out 465b.out README.html
%.out:%.R
	R --no-save < $< > $@
%.html:%.md
	pandoc $< > $@
clean:
	-rm *.out README.html
view:
	-open *.png

