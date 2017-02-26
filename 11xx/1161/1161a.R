library(oce)
library(testthat)

d <- read.oce("CTD_98911_1P_1_DN.txt")

if (!interactive()) png("1161a.png")
par(mfrow=c(1,2))

## 1. test access
expect_equal(length(d[["theta"]]), 127)
expect_equal(head(d[['theta']]), c(0.0346, 0.1563, 0.2153, 0.1970, 0.1916, 0.2141))
plotProfile(d, xtype='theta')

## 2. test assignment (fake signal)
d[["theta"]] <- rep(10, length.out=length(d[["pressure"]]))
expect_equal(length(d[["theta"]]), 127)
expect_equal(head(d[['theta']]), rep(10, 6))
plotProfile(d, xtype='theta')
mtext("EXPECT: vertical line", col="magenta", font=2, line=-1)

if (!interactive()) dev.off()
