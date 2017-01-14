SOURCES=$(wildcard 881*.R)
OBJECTS=$(SOURCES:.R=.out)
all: $(OBJECTS)
%.out: %.R
	R --no-save < $< > $@
clean:
	-rm *.out *.png *.pdf *~ *swp
view:
	-open *.png
download:
	curl http://www3.mbari.org/lobo/Data/FloatVizData/QC/5145HawaiiQC.txt > 5145HawaiiQC.txt
	curl http://www3.mbari.org/lobo/Data/FloatVizData/QC/6401HawaiiQC.txt > 6401HawaiiQC.txt
