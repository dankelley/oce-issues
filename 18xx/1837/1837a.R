setwd("~/git/oce-issues/18xx/1837")

# PURPOSE: test subset-by-pressure or issue "subset doesn't work with sentinel
# V vertical beam data" (https://github.com/dankelley/oce/issues/1837), using a
# dataset provided Clark Richards.
#
# CHECK: In the summaries, is there uniform reduction of length, first index,
# etc., as appropriate to each variable type?

library(oce)

d <- read.oce("sentinel_adcp_example.pd0")
summary(d)

keep <- d[["pressure"]] < median(d[["pressure"]])

dsp <- subset(d, pressure < median(d[["pressure"]]))
summary(dsp)

library(testthat)
expect_equal(sum(keep), dim(dsp[["v"]])[1])
expect_equal(sum(keep), length(dsp[["time"]]))
for (slant in c("v", "a")) { # "g" is NULL
    expect_equal(sum(keep), dim(dsp[[slant]])[1])
}



# Details (d)
str(d@metadata,2)
str(d@data,2)

# Details (dsp)
str(dsp@metadata,2)
str(dsp@data,2)

