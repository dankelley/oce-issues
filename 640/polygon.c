/* vim: set noexpandtab shiftwidth=2 softtabstop=2 tw=70: */
#define DEBUG 1
#include <R.h>
#include <Rdefines.h>
#include <Rinternals.h>
#define POSITIVE(x) ((x) > 0.0)
/*

   system("R CMD SHLIB polygon_subdivide.c") 
   dyn.load("polygon_subdivide.so")

*/

#define NEXT if (++(*no) >= (*nomax)) error("Ran out of space; contact developer.\n")

#define SAVE(x,y) {xo[(*no)]=(x);yo[(*no)]=(y);if (++(*no) >= (*nomax)) error("Ran out of space; contact developer.\n");}

// On input, no is size provided for xo and yo. An error results if we
// run out of space. (It may be sufficient to use no as double
// n.) Otherwise, no is set to the number filled in by the present
// procedure.
void polygon_subdivide_vertically(int *n, double *x, double *y, double *x0,
    int *nomax, int *no, double *xo, double *yo) {
  Rprintf("polygon_chop(*n=%d, ..., *x0=%f, ...)\n", *n, *x0);
  // Buffers: 1 holds the main path, 2 holds sidelobes.  FIXME is
  // double size enough?
  //int N = 2*(*n); double *xbuf = (double*)R_alloc(N,
  //sizeof(double)); double *ybuf = (double*)R_alloc(N,
  //sizeof(double));

  unsigned int *poly_start = (unsigned int*)R_alloc(*(n), sizeof(unsigned int));

  unsigned int *poly_end = (unsigned int*)R_alloc(*(n), sizeof(unsigned int));

  unsigned int ipoly=0, npoly = 0;
  (*no) = 0; // set to 0 by R anyway, but this protects against R changes

  // Separate steps to make it easier to write/debug/read.

  // 1. Find segments
  // Skip any NA at start
  int start;
  for (start = 0; start < (*n)-1; start++) {
    if (!ISNA(x[start]))
      break;
  }
  //Rprintf("first non-NA point at start=%d\n", start);
  poly_start[npoly] = start;
  int i = start;
  while (i < (*n)) {
    // Find first non-NA
    while (ISNA(x[i]) && (i < (*n))) {
      //Rprintf("seeking first non-NA; x[%d] %f\n", i, x[i]);
      i++;
    }
    //Rprintf("poly_start[%d] = %d\n", npoly, i);
    poly_start[npoly] = i;
    // Find last non-NA
    while (!ISNA(x[i]) && (i < (*n))) {
      //Rprintf("seeking last non-NA; x[%d] %f\n", i, x[i]);
      i++;
    }
    //Rprintf("poly_end[%d] = %d\n", npoly, i);
    poly_end[npoly] = i-1;
    npoly++;
    i++;
  }
  if (npoly == 0) 
    error("no polygons\n");
  // Process each polygon individually
  for (ipoly = 0; ipoly < npoly; ipoly++) {
    Rprintf("\npoly %d @ %d to %d\n", ipoly, poly_start[ipoly], poly_end[ipoly]);
    // Find intersection segments
    int j;
    unsigned int *intersection = (unsigned int*)R_alloc(*(n), sizeof(unsigned int));
    int nintersection;
    //int nseg = 1 + poly_end[ipoly] - poly_start[ipoly];
    //Rprintf("  nseg=%d\n", nseg);
    nintersection = 0;
    for (i = poly_start[ipoly], j=poly_end[ipoly]; i < poly_end[ipoly]; j=i++) {
      Rprintf("   x[%d]=%6.2f x[%d]=%6.2f & y[%d]=%6.2f y[%d]=%6.2f\n", i, x[i], j, x[j], i, y[i], j, y[j]);
      if ((x[i] <= (*x0) && (*x0) <= x[j]) || (x[j] <= (*x0) && (*x0) <= x[i])) {
	Rprintf("     the previous point intersects x0=%f\n", (*x0));
	intersection[nintersection++] = i;
      }
    }
    if (nintersection == 0) {
      // This polygon does not intersect x0, so just emit it.
      for (i = poly_start[ipoly]; i < poly_end[ipoly]; i++) {
	//xo[(*no)] = x[i];
	//yo[(*no)] = y[i];
	SAVE(x[i], y[i]);
	Rprintf("     xo[%d]=%6.2f yo[%d]=%6.2f\n", (*no), x[i], (*no), y[i]);
	//if (++(*no) >= (*nomax)) error("Ran out of space at position 1; contact developer.\n");
	//NEXT;
      }
      //xo[(*no)] = NA_REAL;
      //yo[(*no)] = NA_REAL;
      SAVE(NA_REAL, NA_REAL);
      Rprintf("     xo[%d]=%6.2f yo[%d]=%6.2f\n", (*no), x[i], (*no), y[i]);
      //if (++(*no) >= (*nomax)) error("Ran out of space at position 2; contact developer.\n");
      //NEXT;
    } else {
      // This polygon intersects x0, so subdivide and emit the two portions. 
      // Do this by tracing along the path, starting at the intersection
      // point that with the highest y value.
      double ymax = y[poly_start[ipoly]];
      int imax = -1;
      for (i = 1 + poly_start[ipoly]; i <= poly_end[ipoly]; i++) {
	if (y[i] > ymax) {
	  ymax = y[i];
	  imax = i;
	}
      }
      Rprintf("       top y[%d] is %f\n", imax, y[imax]);
      int k = imax-1, kk=imax;
      if (kk > poly_end[ipoly]) // FIXME: probably this is wrong
	kk = poly_start[ipoly]; // FIXME: probably this is wrong
      double epsilon=0.25;
      // Left of x0
      for (i = 0; i <= poly_end[ipoly]-poly_start[ipoly]; i++) {
	Rprintf("   i=%d k=%d kk=%d x[k]=%7.3f y[k]=%7.3f x[kk]=%7.3f y[kk]=%7.3f ", i, k, kk, x[k], y[k], x[kk], y[kk]);
	if ((x[k] <= (*x0) && (*x0) <= x[kk]) || (x[kk] <= (*x0) && (*x0) <= x[k])) {
	  double Y = y[k] + (y[kk]-y[k])*((*x0)-epsilon-x[k])/(x[kk]-x[k]);
	  //Rprintf("     the previous point intersects x0=%f with y=%6.3f\n", (*x0), Y);
	  Rprintf("CASE A (cross): save k=%d %7.3f %7.3f\n", k, (*x0)-epsilon, Y);
	  //xo[(*no)] = (*x0) - epsilon;
	  //yo[(*no)] = Y;
	  Rprintf("    --> fyi x[k] %7.3f,  y[k] %7.3f ; x[kk] %7.3f, y[kk] %7.3f\n", x[k],y[k],x[kk],y[kk]);
	  if (x[k] < x[kk]) {
	    //xo[(*no)] = x[k];
	    //yo[(*no)] = y[k];
	    SAVE(x[k], y[k]);
	    Rprintf(" [ %7.2f %7.2f @ %d]\n", xo[(*no)], yo[(*no)], (*no));
	    //if (++(*no) >= (*nomax)) error("Ran out of space at position 3; contact developer.\n");
	    //NEXT;
	    //xo[(*no)] = (*x0) - epsilon;
	    //yo[(*no)] = Y;
	    SAVE((*x0)-epsilon, Y);
	    Rprintf(" [ %7.2f %7.2f @ %d]\n", xo[(*no)], yo[(*no)], (*no));
	    //if (++(*no) >= (*nomax)) error("Ran out of space at position 3; contact developer.\n");
	  } else {
	    //xo[(*no)] = (*x0) - epsilon;
	    //yo[(*no)] = Y;
	    SAVE((*x0)-epsilon, Y);
	    Rprintf(" [ %7.2f %7.2f @ %d]\n", xo[(*no)], yo[(*no)], (*no));
	    //if (++(*no) >= (*nomax)) error("Ran out of space at position 3; contact developer.\n");
	    //NEXT;
	    //xo[(*no)] = x[kk];
	    //yo[(*no)] = y[kk];
	    SAVE(x[kk], y[kk]);
	    Rprintf(" [ %7.2f %7.2f @ %d]\n", xo[(*no)], yo[(*no)], (*no));
//if (++(*no) >= (*nomax)) error("Ran out of space at position 3; contact developer.\n");
	  }
	} else {
	  if (x[k] <= (*x0)) {
	    Rprintf("CASE B (left):  save k=%d %7.3f %7.3f\n", k, x[k], y[k]);
	    //xo[(*no)] = x[k];
	    //yo[(*no)] = y[k];
	    SAVE(x[k], y[k]);
	    Rprintf(" [ %7.2f %7.2f @ %d]\n", xo[(*no)], yo[(*no)], (*no));
	  } else {
	    Rprintf("CASE C (right): save k=%d %7.3f %7.3f\n", k, (*x0)-epsilon, y[k]);
	    //xo[(*no)] = (*x0) - epsilon;
	    //yo[(*no)] = y[k];
	    SAVE((*x0)-epsilon, y[k]);
	    Rprintf(" [ %7.2f %7.2f @ %d]\n", xo[(*no)], yo[(*no)], (*no));
	  }
	}
	//if (++(*no) >= (*nomax)) error("Ran out of space at position 4; contact developer.\n");
	k++;
	if (k > poly_end[ipoly])
	  k = poly_start[ipoly];
	kk++;
	if (kk > poly_end[ipoly])
	  kk = poly_start[ipoly];
      }
      //xo[(*no)] = NA_REAL;
      //yo[(*no)] = NA_REAL;
      SAVE(NA_REAL, NA_REAL);
      //if (++(*no) >= (*nomax)) error("Ran out of space at position 5; contact developer.\n");
      //NEXT;

#if 1
      // Right of x0
      k = imax;
      kk=imax+1;
      if (kk > poly_end[ipoly]) // FIXME: probably this is wrong
	kk = poly_start[ipoly]; // FIXME: probably this is wrong
      for (i = 0; i <= poly_end[ipoly]-poly_start[ipoly]; i++) {
	Rprintf("       i=%d k=%d kk=%d  x[k]=%7.3f y[k]=%7.3f x[kk]=%7.3f y[kk]=%7.3f\n", i, k, kk, x[k], y[k], x[kk], y[kk]);
	if ((x[k] <= (*x0) && (*x0) <= x[kk]) || (x[kk] <= (*x0) && (*x0) <= x[k])) {
	  double Y = y[k] + (y[kk]-y[k])*((*x0)+epsilon-x[k])/(x[kk]-x[k]);
	  //Rprintf("     the previous point intersects x0=%f with y=%6.3f\n", (*x0), Y);
	  Rprintf(" ** save %7.3f %7.3f now\n", (*x0)+epsilon, Y);
	  //xo[(*no)] = x[kk];
	  //yo[(*no)] = y[kk];
	  //if (++(*no) >= (*nomax))
	  //  error("Ran out of space at position 3; contact developer.\n");
	  if (x[k] > x[kk]) {
	    //xo[(*no)] = x[k];
	    //yo[(*no)] = y[k];
	    SAVE(x[k], y[k]);
	    Rprintf(" [ %7.2f %7.2f @ %d]\n", xo[(*no)], yo[(*no)], (*no));
	    //if (++(*no) >= (*nomax)) error("Ran out of space at position 3; contact developer.\n");
	    //NEXT;
	    //xo[(*no)] = (*x0) + epsilon;
	    //yo[(*no)] = Y;
	    SAVE((*x0)+epsilon, Y);
	    Rprintf(" [ %7.2f %7.2f @ %d]\n", xo[(*no)], yo[(*no)], (*no));
	    //if (++(*no) >= (*nomax)) error("Ran out of space at position 3; contact developer.\n");
	  } else {
	    //xo[(*no)] = (*x0) + epsilon;
	    //yo[(*no)] = Y;
	    SAVE((*x0)+epsilon, Y);
	    Rprintf(" [ %7.2f %7.2f @ %d]\n", xo[(*no)], yo[(*no)], (*no));
	    //if (++(*no) >= (*nomax)) error("Ran out of space at position 3; contact developer.\n");
	    //NEXT;
	    //xo[(*no)] = x[kk];
	    //yo[(*no)] = y[kk];
	    SAVE(x[kk], y[kk]);
	    Rprintf(" [ %7.2f %7.2f @ %d]\n", xo[(*no)], yo[(*no)], (*no));
//if (++(*no) >= (*nomax)) error("Ran out of space at position 3; contact developer.\n");
	  }
	} else {
	  if (x[k] > (*x0)) {
	    Rprintf(" ** save %7.3f %7.3f now\n", x[k], y[k]);
	    //xo[(*no)] = x[k];
	    //yo[(*no)] = y[k];
	    SAVE(x[k], y[k]);
	  } else {
	    Rprintf(" ** save %7.3f %7.3f now\n", (*x0)+epsilon, y[k]);
	    //xo[(*no)] = (*x0) + epsilon;
	    //yo[(*no)] = y[k];
	    SAVE((*x0)+epsilon, y[k]);
	  }
	}
	//if (++(*no) >= (*nomax)) error("Ran out of space at position 6; contact developer.\n");
	k++;
	if (k > poly_end[ipoly])
	  k = poly_start[ipoly];
	kk++;
	if (kk > poly_end[ipoly])
	  kk = poly_start[ipoly];
      }
#endif
    }
  }
}

