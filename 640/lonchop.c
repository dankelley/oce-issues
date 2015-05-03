/* vim: set noexpandtab shiftwidth=2 softtabstop=2 tw=70: */
#define DEBUG 1
#include <R.h>
#include <Rdefines.h>
#include <Rinternals.h>
#define POSITIVE(x) ((x) > 0.0)
/*

   system("R CMD SHLIB lonchop1.c") 
   dyn.load("lonchop1.so")

*/

void lonchop(int *n, double *lon, double *lat, double *lon0, int *no, double *lono, double *lato)
{
  Rprintf("lonchop(*n=%d, ..., *lon0=%f, ...)\n", *n, *lon0);
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
  int ibuf1 = 0, ibuf2 = 0;

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

  int j = 0;
  double epsilon=0.001;
  epsilon=0.1;

  for (iseg = 0; iseg < nseg; iseg++) {
    // Find whether first point is to east or west of lon0. Call this
    // "first_side". Then proceed through the data, storing points in 
    // one of two buffers. For each point, determine the side, named
    // "this_side". If it is on the same as first point, then store the
    // (lon,lat) into the "buf1" buffer. Otherwise, store into the "buf2"
    // buffer. When we pass back into first_side, emit buf2 into
    // (lono, lato) and reset buf2. When all this is done, the final
    // point will be back on first_side (or will assume so). Thus,
    // when buf1 is emited to (lono, lato), we will have completed one
    // side.  FIXME: think more on the logic.
    int first_side = POSITIVE(lon[start]-(*lon0));
    Rprintf("SEGMENT %d\n", iseg);
    for (int i = seg_start[iseg]; i <= seg_end[iseg]; i++) {
      int this_side  = POSITIVE(lon[i]-(*lon0));
      if (this_side != first_side) {
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
  *no = j+1;
}

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
  int ibuf1 = 0, ibuf2 = 0;

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
