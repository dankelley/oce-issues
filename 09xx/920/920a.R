library(oce)
library(testthat)

## 1. See if magic update works
expect_equal("section", oceMagic("example_hy1.csv"))
expect_equal("ctd/woce/exchange", oceMagic("example_ct1.csv"))

## 2. A CTD file
ctd <- read.oce("example_ct1.csv")
expect_equal(names(ctd[["flags"]]), c("pressure", "temperature","salinity", "oxygen"))
expect_equal(names(ctd[["flags"]]), names(ctd[["data"]]))

## 3. A section file
sec <- read.oce("example_hy1.csv")
stn1 <- sec[["station", 1]]
expect_equal(names(stn1[["flags"]]),
             c("salinity","salinityBottle","oxygen","silicate","nitrite","nitrate","phosphate"))


## That's it for tests. We may as well plot. If we plot salinity without 
## handling the flags, it's messed up by -999 values.  Yay, flags!
if (!interactive()) png("920a_1.png")
plot(ctd)
if (!interactive()) {dev.off(); png("920a_2.png")}
plot(stn1)
if (!interactive()) {dev.off(); png("920a_3.png")}
plot(handleFlags(sec))
if (!interactive()) dev.off()
