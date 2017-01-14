SOURCES=$(wildcard *.R)
OBJECTS=$(SOURCES:.R=.out)
all: $(OBJECTS)
%.out: %.R
	R --no-save < $< > $@
clean:
	-rm *.out *.png *.pdf *~ *swp
view:
	-open *.png

download:
	curl http://www.nodc.noaa.gov/woce/woce_v3/wocedata_1/whp/exchange/example_ct1.csv > example_ct1.csv
	curl http://www.nodc.noaa.gov/woce/woce_v3/wocedata_1/whp/exchange/example_hy1.csv > example_hy1.csv

