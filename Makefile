dirs=413 414 415
all:
	for dir in $(dirs); do cd $$dir ; make ; cd .. ; done
clean:
	-rm *~
	for dir in $(dirs); do cd $$dir ; make clean ; cd .. ; done
view:
	-open */*png
	-open */*pdf

