SOURCES=$(wildcard *.R)
OBJECTS=$(SOURCES:.R=.out)
all: $(OBJECTS)
%.out: %.R
	echo ".dump" | sqlite3 060130_20150706_1513.rsk  > 060130_20150706_1513.sql
	## comment-out old code
	#python subsample.py < 060130_20150706_1513.sql > sample.sql
	#-rm sample.rsk
	#sqlite3 sample.rsk < sample.sql
	#gzip -c sample.rsk > sample.rsk.gz
	#rm sample.rsk
	python subsample2.py < 060130_20150706_1513.sql > sample.sql
	-rm sample.rsk
	sqlite3 sample.rsk < sample.sql
	gzip -c sample.rsk > sample.rsk.gz
	rm sample.rsk # for R testing
	R --no-save < $< > $@
clean:
	-rm *.out *.png *.pdf *~ *swp *gz *.sql
view:
	-open *.png
