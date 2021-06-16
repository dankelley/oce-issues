setwd("~/git/oce-issues/18xx/1837")

# PURPOSE: test subset-by-distance or issue "subset doesn't work with sentinel
# V vertical beam data" (https://github.com/dankelley/oce/issues/1837), using a
# dataset provided Clark Richards.
#
# CHECK: In the summaries, is there uniform reduction of second index in
# arrays, as appropriate to each variable type?

library(oce)

d <- read.oce("sentinel_adcp_example.pd0")
summary(d)

keepSlant <- sum(d[["distance"]] < median(d[["distance"]]))
keepVertical <- sum(d[["vdistance"]] < median(d[["distance"]]))

dsd <- subset(d, distance < median(d[["distance"]]))
summary(dsd)

# Tests (will incorporate into local test suite)
library(testthat)
expect_equal(keepSlant, length(dsd[["distance"]]))
expect_equal(keepVertical , length(dsd[["vdistance"]]))
for (vert in c("va", "vq", "vv")) { # no "vg" in this dataset
    expect_equal(keepVertical, dim(dsd[[vert]])[2])
}
for (slant in c("v", "a")) { # "g" is NULL
    expect_equal(keepSlant, dim(dsd[[slant]])[2])
}


# Details (d)
str(d@metadata,2)
str(d@data,2)

# Details (dsp)
str(dsd@metadata,2)
str(dsd@data,2)

