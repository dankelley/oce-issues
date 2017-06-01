library(oce)
library(testthat)
data(section)
stn <- section[["station", 3]]
options(oceDeveloper=NULL)
options(digits=10, width=100)
for (i in 1:2) {
    if (i == 1) options(oceDeveloper=NULL) else options(oceDeveloper=1)
    cat("LOOP i=", i, ", oceDeveloper=", getOption("oceDeveloper"), "\n")
    options(oceEOS="gsw")
    A <- stn[["sigmaTheta"]]
    options(oceEOS="unesco")
    B <- stn[["sigmaTheta"]]

    S <- stn[["salinity"]]
    T <- stn[["temperature"]]
    p <- stn[["pressure"]]
    longitude <- stn[["longitude"]]
    latitude <- stn[["latitude"]]

    AA <- swSigmaTheta(S, T, p, longitude=longitude, latitude=latitude, eos="gsw")
    BB <- swSigmaTheta(S, T, p, eos="unesco")
    ##AA - BB
    ## ensure that manual calculation agrees with [[ method (FIXME: add to test suite)
    expect_equal(A, AA)
    expect_equal(B, BB)

    SA <- stn[["SA"]]
    CT <- stn[["CT"]]
    ## ensure that manual calculation agrees with [[ method (FIXME: add to test suite)
    expect_equal(SA,
                 gsw_SA_from_SP(SP=S, p=p, longitude=longitude, latitude=latitude))
    expect_equal(CT, gsw_CT_from_t(SA=SA, t=T, p=p))

    print(data.frame(S=S, T=T, p=p, SA=SA, CT=CT, st_gsw=AA, st_unesco=BB, diffPercent=200*(AA-BB)/(AA+BB)))
}

