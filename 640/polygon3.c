/* vim: set noexpandtab shiftwidth=2 softtabstop=2 tw=70: */
#define DEBUG 0
#include <R.h>
#include <Rdefines.h>
#include <Rinternals.h>

#define SAVE(x,y) {\
  if ((*no) >= (*nomax)) error("Ran out of space (limit %d pairs); contact developer.\n", (*nomax));\
  xo[(*no)]=(x);\
  yo[(*no)]=(y);\
  ++(*no);\
  if (DEBUG) Rprintf(" [ %7.2f %7.2f @ %3d ]\n", (x), (y), (*no));\
}

// smash the opposite side, retaining y but fixing x as x0 +- epsilon
void polygon_subdivide_vertically3(int *n, double *x, double *y, double *x0,
    int *nomax, int *no, double *xo, double *yo)
{
  Rprintf("polygon_subdivide_vertically3(*n=%d, ..., *x0=%f, *nomax=%d, ...)\n", *n, *x0, *nomax);
  unsigned int *poly_start = (unsigned int*)R_alloc(*(nomax), sizeof(unsigned int));
  unsigned int *poly_end = (unsigned int*)R_alloc(*(nomax), sizeof(unsigned int));
  unsigned int ipoly=0, npoly = 0;
  (*no) = 0; // may be set to 0 by R, but protect against R changes

  // Separate steps to make it easier to write/debug/read.

  // 1. Find polygons.
  // Skip any NA at start
  int start;
  for (start = 0; start < (*n)-1; start++) {
    if (!ISNA(x[start]))
      break;
  }
  poly_start[npoly] = start + 1;
  int i = start;
  while (i < (*n)) {
    // Find first non-NA
    while (ISNA(x[i]) && (i < (*n))) {
      i++;
    }
    poly_start[npoly] = i + 1;
    // Find last non-NA
    while (!ISNA(x[i]) && (i < (*n))) {
      i++;
    }
    poly_end[npoly] = (i == (*n)) ? i - 1 : i;
    npoly++;
    i++;
  }
  if (npoly == 0) 
    error("no polygons\n");
  Rprintf("found %d polygons\n", npoly);
  //
  // 2. Process each polygon individually.
  double epsilon = 0.1;
  // FIXME: might help to interpolate in an additional point near the boundary
  // FIXME: the opposite side is ugly but very thin so maybe OK
  for (ipoly = 0; ipoly < npoly; ipoly++) {
    int crossing = 0;
    double delta0 = x[poly_start[ipoly]] - (*x0);
    for (i = poly_start[ipoly]; i <= poly_end[ipoly]; i++) {
      double delta = x[i] - (*x0);
      if (delta * delta0 < 0.0) {
	crossing = 1;
	break;
      }
    }
    if (crossing) {
      Rprintf("poly %4d @ %d:%d CROSSES\n", ipoly, poly_start[ipoly], poly_end[ipoly]);
      for (i = poly_start[ipoly]; i <= poly_end[ipoly]; i++) {
	//Rprintf("POLY LHS i=%d j=%d\n", i, j);
	if (x[i] > ((*x0) - epsilon)) {
	  SAVE((*x0) - epsilon, y[i])
	} else {
	  SAVE(x[i], y[i])
	}
      }
      SAVE(NA_REAL, NA_REAL);
      for (i = poly_start[ipoly]; i <= poly_end[ipoly]; i++) {
	//Rprintf("POLY RHS i=%d j=%d\n", i, j);
	if (x[i] < ((*x0) + epsilon)) {
	  SAVE((*x0) + epsilon, y[i])
	} else {
	  SAVE(x[i], y[i])
	}
      }
    } else {
      Rprintf("poly %4d @ %d:%d DOES NOT CROSS\n", ipoly, poly_start[ipoly], poly_end[ipoly]);
      for (i = poly_start[ipoly]; i <= poly_end[ipoly]; i++) {
	  SAVE(x[i], y[i])
      }
      SAVE(NA_REAL, NA_REAL);
    }
  }
}

