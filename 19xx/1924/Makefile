SOURCES=$(wildcard [0-9]*.R)
OBJECTS=$(SOURCES:.R=.out)
all: $(OBJECTS)
%.out: %.R
	R --no-save < $< >& $@
clean:
	-rm *.out *.png *.pdf *~ *swp
view:
	-open *.png
