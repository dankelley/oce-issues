## Some issues need no tests, and so the directory sequence has gaps.
## Pattern Makefiles on 356.
dirs=356 402 406 408 409 412 413 414 415 416 418 420 421 423 424\
     425 426 427 428 430 431 432 434 435 437 438 441 443 444 447\
     448 449 450 451 452 453 454 458 459
colormapdirs=431 434 435 437 441 443 447 449 450 452 453 454

all:
	for dir in $(dirs); do cd $$dir ; make ; cd .. ; done
clean:
	-rm *~
	for dir in $(dirs); do cd $$dir ; make clean ; cd .. ; done
view:
	for dir in $(dirs); do cd $$dir ; make view ; cd .. ; done
colormapview:
	for dir in $(colormapdirs); do cd $$dir ; make view ; cd .. ; done

