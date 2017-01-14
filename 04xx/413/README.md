413A.R: test with normal graph, not drawPalette(), on RHS; this shows we need
to thin out the margins to avoid the "margins too wide" error.  The thinning
depends on font size and device size.

413B.R: test with drawPalette() on RHS.

STATUS (2014-04-02): both R files work.  See notes in 413B.R regarding the 'd'
value, and also margins.

