oce-issues
==========

This repository holds test code for working with issues (bugs and new
features) for Oce R package.

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

* The R file(s) should be named as e.g.  ``123.R`` for issue number 123.  If
  there is more than one R file, the names should be e.g.  ``123A.R``,
  ``123B.R``, etc.  Please use multiple R files instead of testing many things
  at once.  Any graphics files created should be named in a way that
  corresponds with the name of the ``*.R`` file.  If an R file produces more
  than one file of graphical output, use dash-separated sequence numbers, e.g.
  ``123.R`` might produce ``123-1.png``, ``123-2,png``, etc.  (Those who are
  accustomed to programming will see that these rules simplify the task of
  the Oce author in determining what output is created by which R file.)

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

Test suites
-----------

Do ``make imagep`` to run a series of tests involving the ``imagep()``
function.  This will clean out previous results, generate new ones, and use
``open`` (an OSX command) to see all the plots.  There are other test suites as
well; see the ``Makefile``.


Collaborators
-------------

At the moment there are two collaborators on this directory.  Others who wish
to collaborate should contact Dan Kelley.  (It might make sense to first
provide some evidence of an ability to code in R and to use git, by cloning
this repository, altering something, and submitting a github pull request.)

-- Dan Kelley, Department of Oceanography, Dalhousie University, Halifax NS
Canada

