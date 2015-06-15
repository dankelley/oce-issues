Problems with end-of-z-range colours have been a problem in many oce functions.
This one relates to ``mapImage()``. My hope is to put *all* code that tests
this general problem into *this* directory. That will spare me from having to
try to sift through GH comments to try to figure out which other directories
might contain *.R files that relate to the present issue. In each case, please
put a ``message()`` call at the start of the R code, stating where the code
originally came from. And, of course, please use purple panel-top text so that
a person can see if the bug is fixed by looking at the plots, not at the R
code.  -- DK
