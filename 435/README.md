# 435.R

*Original.* Use an adp plot to illustrate that Colormap(), soon to be called
colormap(), misses bottom colour, if n=1 but not otherwise.

*Update 1.* The original bug is gone, and I will use this directory also to
work on an extension I'm adding to Colormap(), namely an argument called
``blend``.  The plot title gives ``breaks`` as used by image(), and the plot
itself has coloured dots on top showing the ``col`` (again, as used in image)
and also ``col0`` and ``col1``.  The three panels of 434.png show results for
``blend`` values of 0, 0.5, and 1.  Note that blend=0 is the GMT style, i.e.
``col1`` is ignored.

