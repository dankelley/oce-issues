library(oce)
RMS <- function(x) sqrt(mean(x^2))
#if (file.exists("~/git/oce/R/ctd.R")) {
#    source("~/git/oce/R/sw.R")
#    source("~/git/oce/R/AllClass.R")
#    source("~/git/oce/R/ctd.R")
#}
data(section)
ctd <- section[["station", 100]]
sigma0 <- ctd[["sigma0", "gsw"]]
CT <- ctd[["CT"]]
SA <- ctd[["SA"]]
sigma0direct <- gsw_sigma0(SA=SA, CT=CT)
stopifnot(identical(sigma0, sigma0direct))

cat(sprintf("RMS sigma error: %g kg/m^3 (was nonzero before fixing issue 1933)\n",
       RMS(sigma0 - gsw_sigma0(SA=SA, CT=CT))))

cat("Some reference values\n")
dT <- 0.002
cat(sprintf("RMS sigma if CT changed by %g C: %.5f kg/m^3\n",
        dT,
        RMS(gsw_sigma0(SA=SA, CT=CT+dT) - gsw_sigma0(SA=SA, CT=CT))))
cat(sprintf("RMS diff sigma0 gsw - unesco: %e kg/m^3\n",
        RMS(ctd[["sigma0", "gsw"]] - ctd[["sigma0", "unesco"]])))
