SOURCES=$(wildcard *.R)
OBJECTS=$(SOURCES:.R=.out)
all: $(OBJECTS)
%.out: %.R
	R --no-save < $<
	#R --no-save < $< > $@
clean:
	-rm *.out *.png *~ *swp
view:
	-open *.png
