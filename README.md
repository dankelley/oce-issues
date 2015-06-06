The repository holds test code relating to issues for the oce R package.  See
[the oce site](https://github.com/dankelley/oce/issues) to learn more about the
issues.

The directory structure used here is simple, with one directory per oce issue.
The subdirectory names match the issue numbers, e.g. the ``147`` directory
relates to oce issue [number 147](https://github.com/dankelley/oce/issues/147).
However, not every issue has a corresponding subdirectory here.

Each subdirectory contains a ``Makefile``, and (at least since early 2015)
these have uniform targets: ``make clean`` removes temporary files, ``make``
runs the tests, and ``make view`` shows graphical output (using the ``open``
command in OSX ... other users may need to fake ``open`` to run a graphical
viewer).

At the top level, another ``Makefile`` provides a way to run all the tests, or
to run tests in themes. This is mainly for the developers, and it forms a sort
of torture test for oce, to prevent against the evolving code re-breaking on
old issues.

-- DK
