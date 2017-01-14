/* vim: set noexpandtab shiftwidth=2 softtabstop=2 tw=70: */

// NB. breaking work up into two functions may slow things down but
// it makes it simpler to check.

#include <R.h>
#include <Rdefines.h>
#include <Rinternals.h>

//#define DEBUG // comment this out when working.

/* 

# create data
library(oce)
library(proj4)
library(mapproj)
data(coastlineWorld)
lon <- coastlineWorld[['longitude']]
lat <- coastlineWorld[['latitude']]
xy <- mapproj(coastlineWorld[['longitude']], coastlineWorld[['latitude']], proj="mollweide")
plot(xy$x, xy$y, type='l', asp=1)
mtext("EXPECT: no weird horiz lines", side=3, font=2, col='purple', line=-1.5)
new <- .Call("fixcoast", lon, lat, cutoff)

*/

SEXP fixcoast(SEXP x, SEXP y, SEXP cutoff)
{
  PROTECT(x = AS_NUMERIC(x));
  PROTECT(y = AS_NUMERIC(y));
  PROTECT(cutoff = AS_NUMERIC(cutoff));
  int nx = LENGTH(x);
  int ny = LENGTH(y);
  if (nx != ny) error("lengths of x and y must match but they are %d and %d", nx, ny);
  double *xp = REAL(x);
  double *yp = REAL(y);
  double *cutoffp = REAL(cutoff);
  Rprintf("nx %d, ny %d, cutoff %f\n", nx, ny, *cutoffp);
  SEXP res, res_names, resx, resy;
  PROTECT(res = allocVector(VECSXP, 2));
  PROTECT(res_names = allocVector(STRSXP, 2));
  // count bad spots, so we can allocate space
  int bad = 0;
  double cutoff2 = (*cutoffp) * (*cutoffp);  // work in squared space for speed
  for (int i = 0; i < nx-1; i++) {
    if (!ISNA(xp[i])) {
      double d2 = (xp[i]-xp[i+1])*(xp[i]-xp[i+1]) + (yp[i]-yp[i+1])*(yp[i]-yp[i+1]);
      if (d2 > cutoff2)
	bad++;
    }
  }
  Rprintf("found %d bad points\n", bad);
  // allocate space for those points, then pass through again and insert NA
  PROTECT(resx = allocVector(REALSXP, nx+bad));
  PROTECT(resy = allocVector(REALSXP, ny+bad));
  double *resxp = REAL(resx);
  double *resyp = REAL(resy);
  int j = 0;
  int iadd = 0;
  // FIXME: what about last point?
  for (int i = 0; i < nx-1; i++) {
    if (ISNA(xp[i])) {
      resxp[i+iadd] = NA_REAL;
      resyp[i+iadd] = NA_REAL;
    } else {
      double d2 = (xp[i]-xp[i+1])*(xp[i]-xp[i+1]) + (yp[i]-yp[i+1])*(yp[i]-yp[i+1]);
      resxp[i+iadd] = xp[i];
      resyp[i+iadd] = yp[i];
      if (d2 > cutoff2) {
	Rprintf("i %d xp %f xp+1 %f\n", i, xp[i], xp[i+1]);
	iadd++;
	resxp[i+iadd] = NA_REAL;
	resyp[i+iadd] = NA_REAL;
      }
    }
  }
  resxp[nx+bad-1] = xp[nx];
  resyp[nx+bad-1] = yp[nx];
  if (iadd != bad)
    error("iadd and bad should agree but they are %d and %d", iadd, bad);
  SET_VECTOR_ELT(res, 0, resx);
  SET_STRING_ELT(res_names, 0, mkChar("x"));
  SET_VECTOR_ELT(res, 1, resy);
  SET_STRING_ELT(res_names, 1, mkChar("y"));
  setAttrib(res, R_NamesSymbol, res_names);
  UNPROTECT(7);
  return(res);
}


