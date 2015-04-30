/* vim: set noexpandtab shiftwidth=2 softtabstop=2 tw=70: */
#define DEBUG 1
#include <R.h>
#include <Rdefines.h>
#include <Rinternals.h>
#define LEFT(x) (x < (*lon0))
/*
 
system("R CMD SHLIB lonchop1.c") 
dyn.load("lonchop1.so")


 */
void lonchop(int *n, double *lon, double *lat, double *lon0, double *lono, double *lato)
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
    Rprintf("first non-NA point at start=%d\n", start);
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
