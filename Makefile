## Some issues need no tests, and so the directory sequence has gaps.
## Pattern Makefiles on 356.
dirs=356 402 404 406 408 409 412 413 414 415 416 418 420 421 423\
     424 425 426 427 428 430 431 432 434 435 437 438 441 443 444\
     447 448 449 450 451 452 453 454 456 458 459 462 464 465 475\
     479 481 482 490
colormap=431 434 435 437 441 443 447 449 450 452 453 454
# FIXME: imagep to add: 404 412 413 414 415 415 416 425 434 435 444 452 453 479
imagep=412 431 485 489 490
# Exceptions (since requires private data): 478 486

all:
	for dir in $(dirs) ; do cd $$dir ; make ; cd .. ; done
clean:
	-rm *~
	for dir in $(dirs) ; do cd $$dir ; make clean ; cd .. ; done
view:
	for dir in $(dirs) ; do cd $$dir ; make view ; cd .. ; done
colormap:
	for dir in $(colormap) ; do cd $$dir ; make clean ; make ; make view ; cd .. ; done
imagep:
	for dir in $(imagep)   ; do cd $$dir ; make clean ; make ; make view ; cd .. ; done

