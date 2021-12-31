# MUST install local "develop" version of oce for this to work,
# and note that after this finishes, the CRAN version will
# be installed.
library(oce)
data(ctd)
P <- ctd[["pressure"]]
S <- ctd[["salinity"]]
T <- ctd[["temperature"]]
n <- length(P)
PP <- c(P, P, P, P, P, P, P, P, P, P)
SS <- c(S,
    S+rnorm(n, sd=0.02),
    S+rnorm(n, sd=0.02),
    S+rnorm(n, sd=0.02),
    S+rnorm(n, sd=0.02),
    S+rnorm(n, sd=0.02),
    S+rnorm(n, sd=0.02),
    S+rnorm(n, sd=0.02),
    S+rnorm(n, sd=0.02),
    S+rnorm(n, sd=0.02))
TT <- c(T,
    T+rnorm(n, sd=0.02),
    T+rnorm(n, sd=0.02),
    T+rnorm(n, sd=0.02),
    T+rnorm(n, sd=0.02),
    T+rnorm(n, sd=0.02),
    T+rnorm(n, sd=0.02),
    T+rnorm(n, sd=0.02),
    T+rnorm(n, sd=0.02),
    T+rnorm(n, sd=0.02))
CTD <- as.ctd(SS, TT, PP, longitude=0, latitude=0)

N2development <- swN2(CTD)
remove.packages("oce")
install.packages("oce")
N2CRAN <- swN2(CTD)
fivenum(N2development - N2CRAN)

