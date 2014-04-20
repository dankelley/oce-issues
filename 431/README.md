## 431A.R

Test a trial method for calculating R-style breaks/col given a one-to-one
mapping between value and colour.  I realized after the fact that the twiddling
to get centred bins was silly, since the GMT convention does not work that way.


## 431B.R

Based on 431A.R but realizing that the GMT style will *not* need offseting
breaks.  Use word 'centers' instead of 'breaks' to highlight how this is not
the R approach.  (Naturally, the code must compute breaks to use the R image()
function.) Here, set equal lower and upper colours, one per center.

Test a trial method for calculating R-style breaks/col given a one-to-one
mapping between value and colour.  The results look promising.

## 431C.R

Based on the above (mainly 431B.R) write colormapGMT(), which calculates breaks
and col from the data returned from readGMT().  I suppose colormapGMT() should
read be able to the GMT files directly, but for now I am focussing on the
break/col calculation.

... next: make colormapGMT() read files, and also have args for e.g. fill
colour and missing color. 
