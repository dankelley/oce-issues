/* vim: set noexpandtab shiftwidth=2 softtabstop=2 tw=70: */

// find (begin,end) indices of islands

#include <R.h>
#include <Rdefines.h>
#include <Rinternals.h>

//#define DEBUG // comment this out when working.

/* 

library(oce)
data(coastlineWorld)
lon <- coastlineWorld[['longitude']]
lat <- coastlineWorld[['latitude']]
system("R CMD SHLIB find_islands.c")
dyn.load("find_islands.so")
i <- .Call("find_islands", lon, lat, 120)
# lon[i$begin[1]:i$end[1]]
# lon[i$begin[2]:i$end[2]]
i
plot(c(-180, 180), c(-90, 90), type='n', asp=1, xlab="", ylab="")
for (is in seq_along(i$begin)) {
   span <- seq.int(i$begin[is], i$end[is])
   polygon(lon[span], lat[span], col=1+is%%8)
}

*/

SEXP find_islands(SEXP lon, SEXP lat)
{
  PROTECT(lon = AS_NUMERIC(lon));
  PROTECT(lat = AS_NUMERIC(lat));
  int n = LENGTH(lon);
  int nlat = LENGTH(lat);
  if (n != nlat) error("lengths of lon and lat must match but they are %d and %d", n, nlat);
  double *lonp = REAL(lon);
  double *latp = REAL(lat);
  //Rprintf("n=%d, nlat=%d\n", n, nlat);
  SEXP res, res_names, begin, end;
  // return: start, stop
  //
  PROTECT(res = allocVector(VECSXP, 2));
  PROTECT(res_names = allocVector(STRSXP, 2));
  int *beginp = (int*) R_alloc(n, sizeof(int));
  int *endp = (int*) R_alloc(n, sizeof(int));

  int inIsland = 0;
  int lastNA = 0;
  int island = 0;
  for (int i = 0; i < n; i++) {
    beginp[i] = 0;
    endp[i] = 0;
  }
  for (int i = 0; i < n; i++) {
    if (ISNA(lonp[i])) {
      if (lastNA) {
	continue;
      } else {
	endp[island-1] = i;
      }
      lastNA = 1;
    } else {
      if (lastNA) {
	beginp[island] = i+1;
	lastNA = 0;
	island++;
      } else {
	continue;
      }
    }
  }
  if (!lastNA)
    endp[island-1] = n;
  Rprintf("lastNA=%d", lastNA);
  //Rprintf("got %d islands\n", island);
  PROTECT(begin = allocVector(INTSXP, island));
  PROTECT(end = allocVector(INTSXP, island));
  int *res_beginp = INTEGER(begin);
  int *res_endp = INTEGER(end);
  for (int i = 0; i < island; i++) {
    res_beginp[i] = beginp[i];
    res_endp[i] = endp[i];
    //Rprintf(" copy %d\n", i);
  }
  SET_VECTOR_ELT(res, 0, begin);
  SET_STRING_ELT(res_names, 0, mkChar("begin"));
  SET_VECTOR_ELT(res, 1, end);
  SET_STRING_ELT(res_names, 1, mkChar("end"));
  setAttrib(res, R_NamesSymbol, res_names);
  UNPROTECT(6);
  return(res);
}


