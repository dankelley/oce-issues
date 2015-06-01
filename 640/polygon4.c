/* vim: set noexpandtab shiftwidth=2 softtabstop=2 tw=70: */
#define DEBUG 0
#include <R.h>
#include <Rdefines.h>
#include <Rinternals.h>

int point_in_polygon(double X, double Y, int n, double x[], double y[])
{
  int i, j, c = 0;
  for (i = 0, j = n-1; i < n; j = i++) {
    if (((y[i]>Y) != (y[j]>Y)) && (X < (x[j]-x[i]) * (Y-y[i]) / (y[j]-y[i]) + x[i]))
      c = !c;
  }
  if (c)
    Rprintf("point_in_polygon(%f, %f, %d, ...) is %s\n", X, Y, n, c==0?"outside":"inside");
  return c;
}


#define SAVE(x,y,inside) {\
  if ((*no) >= (*nomax)) error("Ran out of space (limit %d pairs); contact developer.\n", (*nomax));\
  xo[(*no)]=(x);\
  yo[(*no)]=(y);\
  insideo[(*no)]=(inside);\
  ++(*no);\
  if ((inside)) Rprintf(" [ %7.2f %7.2f %d @ %3d ]\n", (x), (y), (inside), (*no));\
}

// 3: smash the opposite side, retaining y but fixing x as x0 +- epsilon
// 4: try to remove UVL
void polygon_subdivide_vertically4(int *n, double *x, double *y, double *x0,
    int *nomax, int *no, double *xo, double *yo, int *insideo)
{
  Rprintf("polygon_subdivide_vertically4(*n=%d, ..., *x0=%f, *nomax=%d, ...)\n", *n, *x0, *nomax);
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
  //Rprintf("found %d polygons\n", npoly);
  //
  // 2. Process each polygon individually.
  double epsilon = 0.25;
  // FIXME: might help to interpolate in an additional point near the boundary
  // FIXME: the opposite side is ugly but very thin so maybe OK
  for (ipoly = 0; ipoly < npoly; ipoly++) {
    //if (ipoly>280) Rprintf("top ipoly=%d\n", ipoly);
    int crossing = 0;
    double delta0 = x[poly_start[ipoly]] - (*x0);
    int poly_len = poly_end[ipoly] - poly_start[ipoly] + 1;
    if (!delta0) {
      crossing = 1;
    } else {
      //Rprintf(" checking ipoly=%d for a cross\n", ipoly);
      for (i = poly_start[ipoly]; i <= poly_end[ipoly]; i++) {
	double delta = x[i] - (*x0);
	if (delta == 0.0 || delta * delta0 < 0.0) {
	  crossing = 1;
	  break;
	}
      }
    }
    double xx;
    if (crossing) {
      //Rprintf("ipoly=%4d npoly=%d @ i=%d:%d (first y %.1f) CROSSES (recall *n=%d)\n", ipoly, npoly, poly_start[ipoly], poly_end[ipoly], y[poly_start[ipoly]], (*n));
      xx = (*x0) - epsilon;
      for (i = poly_start[ipoly]; i <= poly_end[ipoly]; i++) {
	//Rprintf("POLY LHS i=%d\n", i);
	if (i == (*n))
	  return;
	if (x[i] > xx) {
	  SAVE(xx, y[i], point_in_polygon(xx, y[i], poly_len, x+poly_start[ipoly], y+poly_start[ipoly]))
	} else {
	  SAVE(x[i], y[i], 1)
	}
      }
      SAVE(NA_REAL, NA_REAL, 1);
      xx = (*x0) + epsilon;
      for (i = poly_start[ipoly]; i <= poly_end[ipoly]; i++) {
	//Rprintf("POLY RHS i=%d\n", i);
	if (i == (*n))
	  return;
	if (x[i] < xx) {
	  SAVE(xx, y[i], point_in_polygon(xx, y[i], poly_len, x+poly_start[ipoly], y+poly_start[ipoly]))
	} else {
	  SAVE(x[i], y[i], 1)
	}
      }
    } else {
      //Rprintf("ipoly=%4d npoly=%d @ i=%d:%d DOES NOT CROSS (recall *n=%d)\n", ipoly, npoly, poly_start[ipoly], poly_end[ipoly], (*n));
      for (i = poly_start[ipoly]; i <= poly_end[ipoly]; i++) {
	//if (ipoly==286) Rprintf("i=%d %d:%d n=%d\n", i, poly_start[ipoly], poly_end[ipoly], *n);
	if (i < (*n))
	  SAVE(x[i], y[i], 1)
      }
      SAVE(NA_REAL, NA_REAL, 1);
      //if (ipoly==286) Rprintf("done with poly 286\n");
    }
  }
}

