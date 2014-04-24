dirs=356 406 408 409 412 413 414 415 416 418 420 421 423 424 425 426 427 428 430\
     431 432

all:
	for dir in $(dirs); do cd $$dir ; make ; cd .. ; done
clean:
	-rm *~
	for dir in $(dirs); do cd $$dir ; make clean ; cd .. ; done
view:
	for dir in $(dirs); do cd $$dir ; make view; cd .. ; done

