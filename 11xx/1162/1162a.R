## vim:textwidth=80:expandtab

## These tests are likely to go into the built-test suite. Note that if the
## built-in datasets change, these tests will fail. That is intentional,
## actually, because it makes some extra tests against inadvertent changes to
## those datasets ... or, put another way, it imposes a cost to altering the
## datasets.

library(oce)
library(testthat)

## Tests with a funky file, from 1154 (we may need to chop these,
## since it does not make sense to use space in a CRAN package
## with a broken file.

options(digits=10)

test_that("a broken ODF file that has theta but no S", {
          if (1 == length(list.files(pattern="CTD_98911_1P_1_DN.txt"))) {
              d <- read.oce("CTD_98911_1P_1_DN.txt")

              ## 1. test access
              expect_equal(length(d[["theta"]]), 127)
              expect_equal(head(d[['theta']]), c(0.0346, 0.1563, 0.2153, 0.1970, 0.1916, 0.2141))

              ## 2. test assignment
              d[["theta"]] <- seq_along(d[["pressure"]])
              expect_equal(length(d[["theta"]]), 127)
              expect_equal(head(d[['theta']]), 1:6)
          }
})

test_that("accessor operations (ctd)", {
          data(ctd)
          S <- ctd[["salinity"]]
          expect_equal(head(S), c(29.9210, 29.9205, 29.9206, 29.9219, 29.9206, 29.9164))
          ctd[["salinity"]] <- S + 0.01
          SS <- ctd[["salinity"]]
          expect_equal(head(SS), 0.01 + c(29.9210, 29.9205, 29.9206, 29.9219, 29.9206, 29.9164))
          ctd[["SS"]] <- SS
          expect_equal(head(ctd[["SS"]]), 0.01 + c(29.9210, 29.9205, 29.9206, 29.9219, 29.9206, 29.9164))
})

test_that("derived quantities handled properly (ctd)", {
          ## do we get the same theta by both methods, if the object lacks
          ## theta at the start?
          data(ctd)
          expect_null(ctd[["noSuchThing"]])
          thetaByAccessor <- ctd[["theta"]]
          thetaByFunction <- swTheta(ctd)
          expect_equal(thetaByAccessor, thetaByFunction)
          ## Now, insert theta into the object, and alter salinity, to
          ## check that [[ gets the object value and swTheta() computes
          ## a new value.
          ctd[["theta"]] <- thetaByAccessor
          expect_equal(ctd[["theta"]], thetaByAccessor)
          expect_equal(ctd[["theta"]], swTheta(ctd))
          ctd[["S"]] <- ctd[["S"]] + 0.01 # alter S
          ## next values are just what I got from these data, i.e. they only
          ## form a consistency check, if the data or if swTheta() ever change.
          expect_equal(head(swTheta(ctd, eos="unesco")), c(14.22088184, 14.22625401,
                                             14.22480154, 14.22187581,
                                             14.22632183, 14.23281351))
          ## may as well try with both EOSs. Start with the default.
          expect_equal(swTheta(ctd), swTheta(ctd[["salinity"]],
                                             ctd[["temperature"]],
                                             ctd[["pressure"]]))
          expect_equal(swTheta(ctd, eos="unesco"), swTheta(ctd[["salinity"]],
                                             ctd[["temperature"]],
                                             ctd[["pressure"]], eos="unesco"))
          expect_equal(swTheta(ctd, eos="gsw"), swTheta(ctd[["salinity"]],
                                             ctd[["temperature"]],
                                             ctd[["pressure"]], eos="gsw"))
})

test_that("accessor operations (adp)", {
          data(adp)
          v <- adp[["v"]]
          expect_equal(v[1:5,1,1], c(-0.11955770778, -0.09925398341, 0.10203801933,
                                     0.09613003081, 0.24394126236))
          expect_null(adp[["noSuchThing"]])
          adp[["somethingNew"]] <- 1:4
          expect_true("somethingNew" %in% names(adp[["data"]]))
          expect_equal(adp[["somethingNew"]], 1:4)
})

