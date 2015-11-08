The problem is with the arguments, and (excuse alert!) the underlying
difference between the arguments to polygon() and both plot() and lines():

* polygon(ARGS, border = NULL, col = NA, lty = par("lty"), ARGS)

* plot(ARGS, ...) where the ... can contain e.g. ``col`` etc.

The above would argue that we have (ARGS, border=NULL, col=NA, lty=par("lty"),
ARGS), i.e. that we add ``border``, ``col`` and ``lty`` because they will be
familiar to those who use the base functions. A problem is that we want people
to be able to switch styles by just altering ``fill``, and this is tricky
because ``col=NA`` for polygon() will still show the land but for plot() the
land would be invisible.  This argues for *not* setting defaults for ``border``
and ``col``, which complicates coding.

**Possible scheme 1**

Add ``border=NULL``, ``col=NA``, and ``lty=par("lty")`` to the existing args.
Then, process in cases as in pseudo code

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

