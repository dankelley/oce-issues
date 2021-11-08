#include <math.h>
#include <stdio.h>
#include <stdlib.h>

// Use exp(x)=exp(i)*exp(f), where i=floor(x) and f=x-i.  Compute
// exp(i) using a lookup table, and exp(f) using Taylor's rule.
//
// TO DO: test speed, to decide how many Taylor terms to retain.
double fastexp(double x) {
    double rval;
    double ei[] = { // 51 entries, for i=0, -1, -2, ... -50
        1.00000000000000e+00, 3.67879441171442e-01, 1.35335283236613e-01,
        4.97870683678639e-02, 1.83156388887342e-02, 6.73794699908547e-03,
        2.47875217666636e-03, 9.11881965554516e-04, 3.35462627902512e-04,
        1.23409804086680e-04, 4.53999297624849e-05, 1.67017007902457e-05,
        6.14421235332821e-06, 2.26032940698105e-06, 8.31528719103568e-07,
        3.05902320501826e-07, 1.12535174719259e-07, 4.13993771878517e-08,
        1.52299797447126e-08, 5.60279643753727e-09, 2.06115362243856e-09,
        7.58256042791191e-10, 2.78946809286892e-10, 1.02618796317019e-10,
        3.77513454427910e-11, 1.38879438649640e-11, 5.10908902806333e-12,
        1.87952881653908e-12, 6.91440010694020e-13, 2.54366564737692e-13,
        9.35762296884017e-14, 3.44247710846998e-14, 1.26641655490942e-14,
        4.65888614510340e-15, 1.71390843154201e-15, 6.30511676014699e-16,
        2.31952283024357e-16, 8.53304762574407e-17, 3.13913279204803e-17,
        1.15482241730158e-17, 4.24835425529159e-18, 1.56288218933499e-18,
        5.74952226429356e-19, 2.11513103759108e-19, 7.78113224113380e-20,
        2.86251858054939e-20, 1.05306173575538e-20, 3.87399762868719e-21,
        1.42516408274094e-21, 5.24288566336346e-22, 1.92874984796392e-22};
    int i = (int)(floor(x));
    if (i > -51) {
        double I = ei[-i];
        double f = x - i;
        // Use Horner's rule for speed (and perhaps accuracy)
        double F = 1.0 + f * (1.0 + f * (1.0/2.0 + f * (1.0/6.0 + f * (1.0/24.0 + f*(1.0/120.0 + f/720.0)))));
        //printf("i=%d I=%.4f F=%.4f\n",i,I,F);
        rval = I * F;
    } else {
        //printf("using built-in exp()\n");
        rval = exp(x);
    }
    return rval;
}

// Test cases.  In CLI, use e.g.
//    gcc fastexp1.cpp;./a.out -12.34
// (which has -0.0006092% error).
int main(int argc, char *argv[])
{
    double x = atof(argv[1]);
    double e = exp(x);
    double ef = fastexp(x);
    printf("x=%.4f exp=%.4g fastexp=%.4g percentError=%.4g\n", x, e, ef, 100.0*(1.0-e/ef));
}
