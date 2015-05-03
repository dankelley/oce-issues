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

void polygon_subdivide_vertically(int *n, double *x, double *y, double *x0,
    int *no, double *xo, double *yo)
{
  Rprintf("polygon_chop(*n=%d, ..., *x0=%f, ...)\n", *n, *x0);
  // Buffers: 1 holds the main path, 2 holds sidelobes.
  // FIXME is double size enough?
  //int N = 2*(*n);
  // double *xbuf = (double*)R_alloc(N, sizeof(double));
  // double *ybuf = (double*)R_alloc(N, sizeof(double));
  unsigned int *poly_start = (unsigned int*)R_alloc(*(n), sizeof(unsigned int));
  unsigned int *poly_end = (unsigned int*)R_alloc(*(n), sizeof(unsigned int));
  unsigned int ipoly=0, npoly = 0;
  int ibuf = 0;

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
    for (i = poly_start[ipoly], j=poly_end[ipoly]; i <= poly_end[ipoly]; j=i++) {
      Rprintf("   x[%d] %f  x[%d] %f\n", i, x[i], j, x[j]);
      if ((x[i] <= (*x0) && (*x0) <= x[j]) || (x[j] <= (*x0) && (*x0) <= x[i])) {
	Rprintf("     the previous point intersects x0=%f\n", (*x0));
	nintersection++;
      }
    }
    if (nintersection == 0) {
      for (i = poly_start[ipoly]; i < poly_end[ipoly]; i++) {
	xo[(*no)] = x[i];
	yo[(*no)] = y[i];
	Rprintf("     xo[%d]=%f yo[%d]=%f\n", (*no), x[i], (*no), y[i]);
	(*no)++;
      }
      xo[(*no)] = NA_REAL;
      yo[(*no)] = NA_REAL;
      Rprintf("     xo[%d]=%f yo[%d]=%f\n", (*no), x[i], (*no), y[i]);
      (*no)++;
    } else {
      Rprintf("   MUST SUBDIVIDE\n");
    }
    double epsilon=0.001;
    epsilon=0.1;
  }
}

#if 0
void lonchop3(int *n, double *lon, double *lat, double *lon0, double *lono, double *lato)
{
  Rprintf("lonchop3(*n=%d, ..., *lon0=%f, ...)\n", *n, *lon0);
  // Buffers: 1 holds the main path, 2 holds sidelobes.
  // FIXME is double size enough?
  int N = 2*(*n);
  double *lonbuf1 = (double*)R_alloc(N, sizeof(double));
  double *latbuf1 = (double*)R_alloc(N, sizeof(double));
  double *lonbuf2 = (double*)R_alloc(N, sizeof(double));
  double *latbuf2 = (double*)R_alloc(N, sizeof(double));
  unsigned int *seg_start = (unsigned int*)R_alloc(*(n), sizeof(unsigned int));
  unsigned int *seg_end = (unsigned int*)R_alloc(*(n), sizeof(unsigned int));
  unsigned int iseg=0, nseg = 0;
  int ibuf = 0;

  // Separate steps to make it easier to write/debug/read.

  // 1. Find segments
  // Skip any NA at start
  int start;
  for (start = 0; start < (*n)-1; start++) {
    if (!ISNA(lon[start]))
      break;
  }
  //Rprintf("first non-NA point at start=%d\n", start);
  seg_start[nseg] = start;
  int i = start;
  while (i < (*n)) {
    // Find first non-NA
    while (ISNA(lon[i]) && (i < (*n))) {
      //Rprintf("seeking first non-NA; lon[%d] %f\n", i, lon[i]);
      i++;
    }
    //Rprintf("seg_start[%d] = %d\n", nseg, i);
    seg_start[nseg] = i;
    // Find last non-NA
    while (!ISNA(lon[i]) && (i < (*n))) {
      //Rprintf("seeking last non-NA; lon[%d] %f\n", i, lon[i]);
      i++;
    }
    //Rprintf("seg_end[%d] = %d\n", nseg, i);
    seg_end[nseg] = i-1;
    nseg++;
    i++;
  }
  if (nseg == 0) 
    error("no segments\n");
  for (iseg = 0; iseg < nseg; iseg++)
    Rprintf("seg %d @ %d to %d\n", iseg, seg_start[iseg], seg_end[iseg]);


  double epsilon=0.001;
  epsilon=0.1;
  int j = 0;
  int first_on_right = POSITIVE(lon[start]-(*lon0));
  for (int i = start; i < (*n)-1; i++) {
    int this_on_right = POSITIVE(lon[i]-(*lon0));
    if (first_on_right && !this_on_right) {
      // Done with this segment
      first_on_right = this_on_right;
    } else {
      // FIXME: handle NA
      // see if crossing
      double l = lon[i] - (*lon0);
      double r = lon[i+1] - (*lon0);
      // Rprintf("i %d %f %f -> %f %f (%f)\n", i, lon[i], lon[i+1], l, r, *lon0);
      if ((l * r) < 0.0) {
	Rprintf("crosses for i between %d and %d\n", i, i+1);
	double LAT = lat[i] + (lat[i+1]-lat[i])*((*lon0)-lon[i])/(lon[i+1]-lon[i]);
	Rprintf(" lat %f\n", LAT);
	lono[j] = lon[i];
	lato[j] = lat[i];
	j++;
	lono[j] = (*lon0) - epsilon;
	lato[j] = LAT;
	j++;
	lono[j] = (*lon0) + epsilon;
	lato[j] = LAT;
	j++;
      } else {
	lono[j] = lon[i];
	lato[j] = lat[i];
	j++;
      }
    }
  }
}

void lonchop2(int *n, double *lon, double *lat, double *lon0, double *lono, double *lato)
{
  Rprintf("lonchop2(*n=%d, ..., *lon0=%f, ...)\n", *n, *lon0);
  // Buffers: 1 holds the main path, 2 holds sidelobes.
  // FIXME is double size enough?
#if 0
  double *lonbuf1 = (double*)R_alloc(2*(*n), sizeof(double));
  double *latbuf1 = (double*)R_alloc(2*(*n), sizeof(double));
  double *lonbuf2 = (double*)R_alloc(2*(*n), sizeof(double));
  double *latbuf2 = (double*)R_alloc(2*(*n), sizeof(double));
  int ibuf1 = 0, ibuf2;
#endif

  // Skip any NA at start
  int start;
  for (start = 0; start < (*n)-1; start++) {
    if (!ISNA(lon[start]))
      break;
  }
  //Rprintf("first non-NA point at start=%d\n", start);
  double epsilon=0.001;
  epsilon=0.1;
  int j = 0;
  for (int i = start; i < (*n)-1; i++) {
    // FIXME: handle NA
    // see if crossing
    double l = lon[i] - (*lon0);
    double r = lon[i+1] - (*lon0);
    // Rprintf("i %d %f %f -> %f %f (%f)\n", i, lon[i], lon[i+1], l, r, *lon0);
    if ((l * r) < 0.0) {
      Rprintf("crosses for i between %d and %d\n", i, i+1);
      double LAT = lat[i] + (lat[i+1]-lat[i])*((*lon0)-lon[i])/(lon[i+1]-lon[i]);
      Rprintf(" lat %f\n", LAT);
      lono[j] = lon[i];
      lato[j] = lat[i];
      j++;
      lono[j] = (*lon0) - epsilon;
      lato[j] = LAT;
      j++;
      lono[j] = (*lon0) + epsilon;
      lato[j] = LAT;
      j++;
    } else {
      lono[j] = lon[i];
      lato[j] = lat[i];
      j++;
    }
  }
}


void lonchop1(int *n, double *lon, double *lat, double *lon0, double *lono, double *lato)
{
  Rprintf("lonchop1(*n=%d, ..., *lon0=%f, ...)\n", *n, *lon0);
  // FIXME is double size enough?
  //lono = (double*)R_alloc(2*(*n), sizeof(double));
  //lato = (double*)R_alloc(2*(*n), sizeof(double));
  int j = 0; // output pointer
  for (int i = 0; i < (*n)-1; i++) {
    // FIXME: handle NA
    // see if crossing
    double l = lon[i] - (*lon0);
    double r = lon[i+1] - (*lon0);
    // Rprintf("i %d %f %f -> %f %f (%f)\n", i, lon[i], lon[i+1], l, r, *lon0);
    if ((l * r) < 0.0) {
      Rprintf("crosses for i between %d and %d\n", i, i+1);
      double LAT = lat[i] + (lat[i+1]-lat[i])*((*lon0)-lon[i])/(lon[i+1]-lon[i]);
      Rprintf(" lat %f\n", LAT);
    } else {
      lono[j] = lon[i];
      lato[j] = lat[i];
      j++;
    }
  }
}
#endif

