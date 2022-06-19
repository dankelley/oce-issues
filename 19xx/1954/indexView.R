library(Rcpp)
indexViewR <- function(starts, from, to)
{
    if (missing(starts) || missing(from) || missing(to))
        stop("give 'starts', 'from' and 'by'")
    seq <- seq(from, to)
    unlist(lapply(starts, function(start) start + seq(from, to)))
}

cppFunction('IntegerVector indexViewC(IntegerVector starts, IntegerVector from, IntegerVector to) {
    int nstarts = starts.size();
    int n = nstarts * (to[0] - from[0] + 1);
    IntegerVector res(n);
    int j = 0;
    for (int i = 0; i < nstarts; i++) {
        for (int fromto = from[0]; fromto <= to[0]; fromto++) {
            res[j] = starts[i] + fromto;
            j++;
        }
    }
    return res;
}')

# for 1e6 starts, R takes 7.6s, C takes 0.017s
# R <- c(7.646, 7.362, 7.183, 7.544, 7.435)
# t.test(R) # 7.4 +- 0.2s
# C <- c(0.011, 0.012, 0.012, 0.012, 0.012)
# t.test(C) # 0.012 +- 0.0005s
# Thus C is 625X faster than R

system.time(iR <- indexViewR(100*(1:1e6), 0, 3))
system.time(iC <- indexViewC(100*(1:1e6), 0, 3))
stopifnot(all.equal(iR, iC))

