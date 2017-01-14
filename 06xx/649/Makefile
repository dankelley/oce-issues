SOURCES=$(wildcard *.R)
OBJECTS=$(SOURCES:.R=.out)
all: $(OBJECTS)
%.out: %.R
	echo "DK can supply the ODF files needed to run the oce-issues/649 tests."
	-R --no-save < $< > $@
clean:
	-rm *.out *.png *.pdf *~ *swp
view:
	-open *.png
