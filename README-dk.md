It is time to get serious about these "figure margins too large" bugs!  This is
a diary of what I learned exploring the code.

# File list

(In the following sections, the full path names are not used.)

``R-3.0.3/src/library/graphics/src/graphics.c``

``src/library/graphics/R/layout.R``


# Error msg trace/cause

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

# Layout effects

A flag ``dp->layout`` is defined false initially at ``graphics.c:2178``.

I think ``gpptr(dd)->widths`` is a vector of widths, etc; see
``graphics.c:971`` for a summation and ``graphics.c:2188`` for initialization.

Q: could ``layout()`` and ``par(mfrow)`` work the same way, with the latter
just using equal widths and heights?

# Layout code

``layout.R`` seems to hand all the real work over to ``.External.graphics``,
but *where* is that??
