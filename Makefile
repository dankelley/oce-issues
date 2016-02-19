## Some issues need no tests, so the directory sequence has gaps.
## Copy Makefiles from Makefile.skeleton
## Exceptions (since requires private data): 478 486

# TEST SETS
# 'make all' tests everything
# 'make imagep' tests (and displays results) for imagep() bugs
# For similar tests, look at looping blocks near bottom.
dirs        =147 \
	     337 356 388 390 402 404 406 408 409 412 413 414 415 416 418 \
             420 421 423 424 425 426 427 428 430 431 432 434 435 437 438 \
             441 443 444 447 448 449 450 451 452 453 454 456 458 459 462 \
	     464 465 475 479 481 482 490 495 501 502 504 506 508 510 513 \
	     514 516 517 518 519 520 525 526 531 533 536 537 539 540 541 \
             543 544 545 546 548 554 557 562 563 568 572 576 577 579 581 \
	     584 585 586 588 592 595 611 612 613 616 620 622 623 624 627 \
	     628 630 631 635 636 637 638 640 641 642 648 649 653 655 657 \
	     658 659 661 663 664 665 667 669 670 671 672 675 677 678 679 \
	     692 694 696 698 699 704 705 707 708 710 721 726 729 730 731 \
	     740 756 757 759 760 763 766 768 769 770 774 777 782 783 785 \
	     800 805 816 817 818 826 827 828 829 833 838 839 843 861 868\
	     870 872 874

# current is the issue being worked on most actively
current     = 861

adp         =586 696 704 777 782 783 785
amsr        =839
argo        =510 521 548 817 829 833
bremen      =659
cm          =740
colormap    =437 441 443 447 449 450 452 453 454 517 637
ctd         =402 432 438 456 475 477 498 520 525 595 563 620 627 642 670 \
	     677 692 698 705 710 731 756 816 828 861 870
extras655   =368 516 655
g1sst       =843
group516    =516 517 489 337 368 # CR related 3xx; DK related others
gsw         =557
imagep      =368 390 404 412 413 414 415 416 424 425 431 434 435 437 444 \
	     452 453 479 485 489 490 516 581 585 586 655 726 805 826 827
landsat     =465 484 486 501 502 506 508 519 572 592 675 868 874
map         =388 495 514 517 518 520 521 522 523 533 537 541 543 545 576 \
	     577 584 653 663 664 665 721 726 774
mapnew      =388 495 514 517 518 520 521 522 523 533 537 541 543 545 576 \
	     577 584 653 # skip those using mapproj
mapImage    =309 336 368 516 517 522 655 721 726
odf         =649 715 729 730
projections =388 495 518 520 521 537 635 638
proj4       =518 520 533 579
RDItests    =785
rsk         =562 588 622 623 624 627 642 679 800
satellite   =$(amsr) $(landsat) $(g1sst)
section     =456 658 817 818 838
ts          =147 531
UHL         =388 # horiz lines on maps


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
issue655: 
	for dir in $(extras655)   ; do cd $$dir ; make clean ; make ; make view ; cd .. ; done
adp:
	for dir in $(adp)         ; do cd $$dir ; make clean ; make ; make view ; cd .. ; done
bremen:
	for dir in $(bremen)      ; do cd $$dir ; make clean ; make ; make view ; cd .. ; done
colormap:
	for dir in $(colormap)    ; do cd $$dir ; make clean ; make ; make view ; cd .. ; done
ctd:
	for dir in $(ctd)         ; do cd $$dir ; make clean ; make ; make view ; cd .. ; done
drifter:
	for dir in $(drifter)     ; do cd $$dir ; make clean ; make ; make view ; cd .. ; done
group516:
	for dir in $(group516)    ; do cd $$dir ; make clean ; make ; make view ; cd .. ; done
gsw:
	for dir in $(gsw)         ; do cd $$dir ; make clean ; make ; make view ; cd .. ; done
imagep:
	for dir in $(imagep)      ; do cd $$dir ; make clean ; make ; make view ; cd .. ; done
map:
	for dir in $(map)         ; do cd $$dir ; make clean ; make ; make view ; cd .. ; done
mapnew:
	for dir in $(mapnew)      ; do cd $$dir ; make clean ; make ; make view ; cd .. ; done
mapImage:
	for dir in $(mapImage)    ; do cd $$dir ; make clean ; make ; make view ; cd .. ; done
projections:
	for dir in $(projections) ; do cd $$dir ; echo $$dir ; make clean ; make ; make view ; cd .. ; done
landsat:
	for dir in $(landsat)     ; do cd $$dir ; make clean ; make ; make view ; cd .. ; done
rsk:
	for dir in $(rsk)         ; do cd $$dir ; make clean ; make ; make view ; cd .. ; done
ugly:
	for dir in $(ugly)        ; do cd $$dir ; make clean ; make ; make view ; cd .. ; done
section:
	for dir in $(section)     ; do cd $$dir ; make clean ; make ; make view ; cd .. ; done
ts:
	for dir in $(ts)          ; do cd $$dir ; make clean ; make ; make view ; cd .. ; done
RDItests:
	for dir in $(RDItests)    ; do cd $$dir ; make clean ; make ; make view ; cd .. ; done
