SOURCES=$(wildcard *.R)
OBJECTS=$(SOURCES:.R=.out)
all: $(OBJECTS)
%.out: %.R
	R --slave < $< > $@
clean:
	-rm *.out *.png *.pdf *~ *swp
view:
	-open *.png
