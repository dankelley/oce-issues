oce-issues
==========

Test code for working with issues (bugs and new features) for Oce R package.

Directory setup and work flow
-----------------------------

Subdirectories here are named for issue number.  Inside each is a Makefile with
a default target that does some test, plus a ``clean`` target that removes
unwanted files.  The top level has a Makefile that recursively calls Makefiles
in the subdirectories.  

Thus, the work flow for a new issue involves: (1) create a new subdirectory,
and populate it with a Makefile (typically by copying the Makefile in another
subdirectory), (2) add the new subdirectory name to the beginning of the
top-level Makefile, and then (3) work on the bug in the subdirectory.

In order to prevent full rebuilds of Oce for each test, it is important that
the Oce source be located in ``~/src``, so that the standard source call might
be something like ``source("~/src/oce/R/imagep.R")``, where the author is
adjusting the named function.

Collaborators
-------------

At the moment there are two collaborators on this directory.  Others who wish
to collaborate should contact Dan Kelley.  (It might make sense to first
provide some evidence of an ability to code in R and to use git, by cloning
this repository, altering something, and submitting a github pull request.)

-- Dan Kelley, Department of Oceanography, Dalhousie University, Halifax NS
Canada

