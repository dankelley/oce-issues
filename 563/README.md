# The issue

subset(tdr) is failing if called within a function. This was reported by CR
with a script based on separate data, and boiled down to 01.R here.

There seems little doubt that the problem will apply to other Oce objects, but
the plan is to try for a solution first on tdr.

# Status

The problem seems to have been resolved in the ``subset`` branch (commit
8f48102454c53d8f9435361dcfcbff95a1895ae2).  Probably it would make sense to do
some more testing before transferring the apparent solution from the tdr case
to other cases.

# Tests

01.R similar to CR
02.R define start and end in function
03.R do the subset outside the function
04.R like 01.R but with a function one level deeper
05.R like 01.R but with a function one level deeper

# Resources

* [a nabble
  comment]{http://r.789695.n4.nabble.com/getting-environment-from-quot-top-quot-promise-td4685138.html}
provided the solution: use parent.frame(2) instead of parent.frame().

