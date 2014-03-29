oce-issues
==========

This repository holds test code for working with issues (bugs and new features)
for Oce R package.

Directory setup
---------------

The subdirectories are named for issue number.   Each is to test just one
issue, with the number being as given in the [Oce issues
webpage](https://github.com/dankelley/oce/issues?state=open).

A strict naming convention is followed in these subdirectories.  Each is to
have a ``Makefile``, one or more ``*.R`` file, and optionally a ``README.md``
file.  Please see the ``413`` directory for example.

* The Makefile should have a default target that does some test, a ``clean``
  target that removes unwanted files, and a ``view`` target that shows any
  relevant image files (typically using ``open``, an OSX command, since the
  main collaborators are OSX users).

* The R file(s) should be named as e.g.  ``oce123.R`` for issue number 123.  If
  there is more than one R file, the names should be e.g.  ``oce123A.R``,
  ``oce123B.R``, etc.  Please use multiple R files instead of testing many things
  at once.  

* The ``README.md`` file should state briefly what the files are supposed to
  test (and especially that states what's wrong in the results).

The top level has a ``Makefile`` that recursively calls Makefiles in the
subdirectories.  

Work flow
---------

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

