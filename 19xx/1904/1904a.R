# Test sigmaTheta, sigma[0:4] for a deep profile
library(oce)
library(testthat)
data(section)
stn <- section[["station", 100]] # 4.3km deep

# Tests of each pressure level.  (The printout is just for interest.)
for (item in paste0("sigma", 0:4)) {
    options(oceEOS="unesco")
    unesco <- stn[[item]]
    options(oceEOS="gsw")
    gsw <- stn[[item]]
    expect_equal(stn[[item, "unesco"]], unesco)
    expect_equal(stn[[item, "gsw"]], gsw)
    cat("FYI, ", item, " mean(unesco-gsw) = ", mean(unesco-gsw), "\n", sep="")
}

# The following tests are also in "~/git/oce/tests/testthat/test_sw.R"

# Ensure that the sigmaTheta is the same whether called directly or with [[
expect_equal(swSigmaTheta(stn,eos="unesco"), stn[["sigmaTheta", "unesco"]])
expect_equal(swSigmaTheta(stn,eos="gsw"), stn[["sigmaTheta", "gsw"]])

# The oceEOS option must be obeyed.
options(oceEOS="unesco")
expect_equal(stn[["sigmaTheta"]], stn[["sigma0", "unesco"]])
options(oceEOS="gsw")
expect_equal(stn[["sigmaTheta"]], stn[["sigma0", "gsw"]])

# sigmaTheta and sigma0 should match within each EOS.
expect_equal(stn[["sigmaTheta", "unesco"]], stn[["sigma0", "unesco"]])
expect_equal(stn[["sigmaTheta", "gsw"]], stn[["sigma0", "gsw"]])

# sigmaTheta and sigma0 ([[ form) should not match between unesco and gsw
expect_false(identical(stn[["sigmaTheta", "gsw"]], stn[["sigmaTheta", "unesco"]]))
expect_false(identical(stn[["sigma0", "gsw"]], stn[["sigma0", "unesco"]]))

# sigmaTheta and sigma0 (function form) should not match between unesco and gsw
expect_false(identical(swSigmaTheta(stn,eos="unesco"), swSigmaTheta(stn,eos="gsw")))
expect_false(identical(swSigma0(stn,eos="unesco"), swSigma0(stn,eos="gsw")))

