SOURCES=$(wildcard *.R)
OBJECTS=$(SOURCES:.R=.out)
#all: $(OBJECTS)
all:
	echo "this issue is now moot "
%.out: %.R
	R --no-save < $< > $@
clean:
	-rm *.out *.png *.pdf *~ *swp
view:
	-open *.png
