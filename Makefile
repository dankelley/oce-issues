## Some issues need no tests, and so the directory sequence has gaps.
## Pattern Makefiles on 356.
## Exceptions (since requires private data): 478 486

# TEST SETS
# 'make all' tests everything
# 'make imagep' tests (and displays results) for imagep() bugs
# For similar tests, look at looping blocks near bottom.
dirs        =337 356 388 390 402 404 406 408 409 412 413 414 415 416 418 \
             420 421 423 424 425 426 427 428 430 431 432 434 435 437 438 \
             441 443 444 447 448 449 450 451 452 453 454 456 458 459 462 \
	     464 465 475 479 481 482 490 495 501 502 504 506 508 510 513 \
	     514 516 517 518 519 520 525 526 531
colormap    =437 441 443 447 449 450 452 453 454 517
imagep      =368 390 404 412 413 414 415 416 424 425 431 434 435 437 444 \
	     452 453 479 485 489 490 516
map         =514 517 522 523
mapImage    =517 522
ctd         =402 432 438 475 477 498 520 525
ugly        =388 # horiz lines on maps
projections =388 495 518 520 521
landsat     =465 484 486 501 502 506 508 519
drifter     =510 521
group516    =516 517 489 337 368 # CR related 3xx; DK related others
proj4       =518 520
current     =531

all:
	for dir in $(dirs) ; do cd $$dir ; make ; cd .. ; done
clean:
	-rm *~
	for dir in $(dirs) ; do cd $$dir ; make clean ; cd .. ; done
view:
	for dir in $(dirs) ; do cd $$dir ; make view ; cd .. ; done
current:
	for dir in $(current) ; do cd $$dir ; make clean ; make ; make view ; cd .. ; done

## Themed tests (alphabetical)
colormap:
	for dir in $(colormap) ; do cd $$dir ; make clean ; make ; make view ; cd .. ; done
ctd:
	for dir in $(ctd) ; do cd $$dir ; make clean ; make ; make view ; cd .. ; done
drifter:
	for dir in $(drifter) ; do cd $$dir ; make clean ; make ; make view ; cd .. ; done
group516:
	for dir in $(group516) ; do cd $$dir ; make clean ; make ; make view ; cd .. ; done
imagep:
	for dir in $(imagep) ; do cd $$dir ; make clean ; make ; make view ; cd .. ; done
map:
	for dir in $(map) ; do cd $$dir ; make clean ; make ; make view ; cd .. ; done
mapImage:
	for dir in $(mapImage) ; do cd $$dir ; make clean ; make ; make view ; cd .. ; done
projections:
	for dir in $(projections) ; do cd $$dir ; make clean ; make ; make view ; cd .. ; done
landsat:
	for dir in $(landsat) ; do cd $$dir ; make clean ; make ; make view ; cd .. ; done
ugly:
	for dir in $(ugly) ; do cd $$dir ; make clean ; make ; make view ; cd .. ; done
