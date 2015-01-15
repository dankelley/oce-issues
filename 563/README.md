# The issue

``subset(tdr, ...)`` is failing if called within a function. This was reported
by CR with a script based on separate data, and boiled down to 01.R here.

There seems little doubt that the problem will apply to other Oce objects, but
the plan is to try for a solution first on ``tdr`` objects.

# Status

The problem seems to have been resolved in the ``subset`` branch (commit
8f48102454c53d8f9435361dcfcbff95a1895ae2).  Probably it would make sense to do
some more testing before transferring the apparent solution from the ``tdr`` case
to other cases.

# Tests

* ``01.R`` similar to CR
* ``01ctd.R`` as ``01.R`` but for ctd
* ``02.R`` define ``start`` and ``end`` in function
* ``02ctd.R`` as ``02.R`` but for ctd
* ``03.R`` do the subset outside the function
* ``03ctd.R`` as ``03.R`` but for ctd
* ``04.R`` like ``01.R`` but with a function one level deeper
* ``04ctd.R`` as ``04.R`` but for ctd
* ``05.R`` like ``01.R`` but with a function one level deeper
* ``05ctd.R`` as ``05.R`` but for ctd

# Resources

[a nabble comment](http://r.789695.n4.nabble.com/getting-environment-from-quot-top-quot-promise-td4685138.html)
provided the solution: use ``parent.frame(2)`` instead of ``parent.frame()``.

