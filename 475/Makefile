all: 475a1.out 475a2.out 475a3.out 475b.out 475c.out 475d.out 475e.out
%.out:%.R
	R --no-save < $< > $@
%.html:%.md
	pandoc $< > $@
clean:
	-rm *.out *.png
view:
	-open *.png

