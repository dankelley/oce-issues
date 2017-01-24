## Unable to specify tidal constituents using tidem() #1179
## https://github.com/dankelley/oce/issues/1179

library(oce)
library(testthat)
data(sealevel)
data(tidedata)

## The text given below is from the docs (updated for this issue):
##
## A specific example may be of help in understanding the removal of unresolvable
## constitutents. For example, the \code{data(sealevel)} dataset is of length
## 6718 hours, and this is too short to resolve the full list of constituents,
## with the conventional (and, really, necessary) limit of \code{rc=1}.
## From Table 1 of [1], this timeseries is too short to resolve the 
## \code{SA} constituent, so that \code{SA} will not be in the resultant.
## Similarly, Table 2 of [1] dictates the removal of
## \code{PI}, \code{S1} and \code{PSI1} from the list. And, finally,
## Table 3 of [1] dictates the removal of
## \code{H1}, \code{H2}, \code{T2} and \code{R2}.  Also, since Table 3
#' of [1] indiates that \code{GAM2} gets subsumed into \code{H1},
#' and if \code{H1} is already being deleted in this test case, then
#' \code{GAM2} will also be deleted.

standard <- c("Z0", "SA", "SSA", "MSM", "MM", "MSF", "MF", "ALP1", "2Q1",
              "SIG1", "Q1", "RHO1", "O1", "TAU1", "BET1", "NO1", "CHI1", "PI1",
              "P1", "S1", "K1", "PSI1", "PHI1", "THE1", "J1", "SO1", "OO1",
              "UPS1", "OQ2", "EPS2", "2N2", "MU2", "N2", "NU2", "GAM2", "H1",
              "M2", "H2", "MKS2", "LDA2", "L2", "T2", "S2", "R2", "K2", "MSN2",
              "ETA2", "MO3", "M3", "SO3", "MK3", "SK3", "MN4", "M4", "SN4",
              "MS4", "MK4", "S4", "SK4", "2MK5", "2SK5", "2MN6", "M6", "2MS6",
              "2MK6", "2SM6", "MSK6", "3MK7", "M8")

unresolvable <- c("SA", "PI1", "S1", "PSI1", "GAM2", "H1", "H2", "T2", "R2")

## remove the ones we cannot resolve WITH THIS PARTICULAR dataset
resolvable<- standard[!(standard %in% unresolvable)]

tide1 <- tidem(sealevel)
expect_equal(tide1[["data"]]$name, resolvable)

tide2 <- tidem(sealevel, constituents="standard")
expect_equal(tide1[["data"]]$name, tide2[["data"]]$name)

## check names; note that "Z0" goes in by default
tide3 <- tidem(sealevel, constituents = c("M2", "K2"))
expect_equal(tide3[["data"]]$name, c("Z0", "M2", "K2"))

## check that missing(constituents) and constitudes="standard" are same
tide4 <- tidem(sealevel, constituents="standard") 
expect_equal(tide4[["data"]]$name, resolvable)

## check that we can remove constituents
tide5 <- tidem(sealevel, constituents = c("standard", "-M2")) 
expect_equal(tide5[["data"]]$name, resolvable[resolvable != "M2"])

