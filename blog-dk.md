# 2014-03-30 How does ``layout()`` work internally?

(This relates to 416.)

It is time to get serious about these "figure margins too large" bugs!  This is
a diary of what I learned exploring the code.

## File list

(In the following sections, the full path names are not used.)

``~/src/R-3.0.3/src/library/graphics/src/graphics.c``

``~/src/R-3.0.3/src/library/graphics/src/par.R``

``~/src/R-3.0.3/src/library/graphics/R/layout.R``


## Error msg trace/cause

The error msg comes from ``graphics.c:1845`` and results from a false return
value from ``validFigureMargins()``, defined (starting at line 1732) as
follows.

```c
static Rboolean validFigureMargins(pGEDevDesc dd)
{
    return ((gpptr(dd)->plt[0] < gpptr(dd)->plt[1]) &&
	    (gpptr(dd)->plt[2] < gpptr(dd)->plt[3]));
}
```

From the above, we can guess that ``gpptr(dd)->plot`` is a 4-element vector
with xleft first, then xright, then ybottom, then ytop (x and y could be
switched but the main thing is that ``plt`` is the key element of ``gpptr``).

## Layout effects

A flag ``dp->layout`` is defined false initially at ``graphics.c:2178``.

I think ``gpptr(dd)->widths`` is a vector of widths, etc; see
``graphics.c:971`` for a summation and ``graphics.c:2188`` for initialization.

Q: could ``layout()`` and ``par(mfrow)`` work the same way, with the latter
just using equal widths and heights?

## Layout code

``layout.R`` uses a call to ``.External.graphics`` to hand the low-level
processing to ``C_layout``, defined starting at in ``par.c:1150``.  As noted in
the comments above that line, this came from the Paul Murrell thesis.

## Some trial and error

A couple of hours of reading have convinced me that the C code is tricky.  (The
comments there quote Apocalypse Now, "The Horror".)

* ``416/416layout.R`` is an attempt to learn how layout() controls par("fin")
etc.  The problem is that par("fin") before the first plot gives the width of
the *second* plot.

* ``416/416layout2.R`` uses a trick using frame() and then par(new=TRUE), which
yields par("fin") values that make sense.

