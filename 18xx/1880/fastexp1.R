# For the Barnes algorithm, we have exp(-distance^2), which is always exp(x)
# where x <= 0.
#
# Idea: write e.g.  exp(-5.1) as exp(-6) * exp(0.9),
# and use lookup table for the first part, for maybe -50 to 0 or
# whatever, and then make a lookup table or Taylor series (as below)
# for the fraction part.

# Integer part
xi <- seq(0, 50, 1)
ei <- exp(-xi)

# Taylor series
taylor <- function(x)
{
    1 + x * (1 + x * (1/2 + x * (1/6 + x * (1/24 + x*(1/120 + x/720)))))
}

# Combine
EXP <- function(x)
{
    i <- as.integer(floor(x))
    f <- x - i
    I <- ei[1-i]
    F <- taylor(f)
    #message("i=", i, " I=",I, " f=", f, " F=", F)
    I * F
}

# Test
x <- seq(-20, 0, length.out=1000)
E <- unlist(lapply(x, EXP))
plot(x, 100*(1-E/exp(x)), type="o", pch=20, cex=0.5, ylab="Percent error")

library("Rcpp")
cppFunction("
    double fastexp(double x) {
        double ei = {1.000000e+00, 3.678794e-01, 1.353353e-01, 4.978707e-02,
        1.831564e-02, 6.737947e-03, 2.478752e-03, 9.118820e-04, 3.354626e-04,
        1.234098e-04, 4.539993e-05, 1.670170e-05 6.144212e-06, 2.260329e-06,
        8.315287e-07, 3.059023e-07, 1.125352e-07, 4.139938e-08, 1.522998e-08,
        5.602796e-09, 2.061154e-09, 7.582560e-10, 2.789468e-10, 1.026188e-10
        3.775135e-11 1.388794e-11 5.109089e-12 1.879529e-12 6.914400e-13
        2.543666e-13 9.357623e-14 3.442477e-14 1.266417e-14 4.658886e-15
        1.713908e-15 6.305117e-16 2.319523e-16 8.533048e-17 3.139133e-17
        1.154822e-17 4.248354e-18 1.562882e-18 5.749522e-19 2.115131e-19
        7.781132e-20 2.862519e-20 1.053062e-20 3.873998e-21 1.425164e-21
        5.242886e-22 1.928750e-22};  
        int i = (int)(floor(x));
        double f = x - i;
        I <- ei[-i]
        F = 1.0 + x * (1.0 + x * (1.0/2.0 + x * (1.0/6.0 + x * (1.0/24.0 + x*(1.0/120.0 + x/720.0)))));
        return double(I) * F;
    }")
fastexp(1)
