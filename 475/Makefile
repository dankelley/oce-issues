all: 475A.out 475B.out 475C.out
%.out:%.R
	R --no-save < $< > $@
%.html:%.md
	pandoc $< > $@
clean:
	-rm *.out *.png
view:
	-open *.png

