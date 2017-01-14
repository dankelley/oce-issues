The problem is with the arguments, and (excuse alert!) the underlying
difference between the arguments to ``polygon()`` and both ``plot()`` and
``lines()`` (below are the docs, *sans* other args):

* ``polygon(border = NULL, col = NA, lty = par("lty"))``

* ``plot(...)`` where ``...`` can contain e.g. ``col`` etc.

The above would argue that we have defaults ``border=NULL``, ``col=NA``,
``lty=par("lty")`` in order to make things familiar for those who know
``polygon``. But then we have users who are familiar with ``plot()`` and
``lines()``, for whom ``col`` has a different meaning. This is the essence of
the challenge.

It would be nice if users could switch styles by simply altering ``fill``. But
that means that the defaults for ``polygon()`` cannot work (e.g. consider
``col``). This makes me think that ``border`` and ``col`` should *not* have
default arguments, but things should up so that the results of not supplying
the args will be as expected for line-type or polygon-type cases.

On top of this, we want to handle existing cases as they are, if at all
possible.

It's complicated! And one thing is for sure: failing to figure out the subcases
in advance will make the programming challenge 10 times harder, and also make
it harder for users.

I will use this README for some thoughts. I propose that if CR wants to add
notes, that he make a new README-cr.md file, or that he does notes within the
present file with some scheme that lets us see who wrote what. Otherwise, we
can get into the confusion of GH comments, which is what I'm trying to avoid
here, in more of an essay style as opposed to the short-answer sort of style
(you can tell I should be grading right now!)

**DK1 pseudocode**

```R
if (is.logical(fill)) {
  # A new case
  if (fill) {
    # case A
    # Note that fill=TRUE is like the old default fill='lightgray'
    polygon(..., border = if (missing(border)) "black" else border,
                 col = if (missing(col)) "lightgray" else col)
  } else {
    # case B
    plot(..., col = if (!missing(border)) border else if (!missing(col)) col else "black")
} else if (is.null(fill)) {
  # case C: identicl to case B
} else {
  if (fill can be interpreted as a colour) {
    # case D: compatibility mode; note that col is now ignored
    polygon(..., border=border, col=fill, ...) # FIXME: check that border comes out black
  } else {
    stop("'fill' must be NULL, a logical or a colour")
  }
}
```

