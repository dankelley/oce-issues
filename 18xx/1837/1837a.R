# FILE: oce-issues/18xx/1837/1837a.R
#
# PURPOSE: test subset-by-pressure or issue "subset doesn't work with sentinel
# V vertical beam data" (https://github.com/dankelley/oce/issues/1837), using a
# dataset provided Clark Richards.
#
# CHECK: In the summaries, is there uniform reduction of length, first index,
# etc., as appropriate to each variable type?

library(oce)

d <- read.oce("sentinel_adcp_example.pd0")
summary(d)

dsp <- subset(d, pressure < median(d[["pressure"]]))
summary(dsp)

