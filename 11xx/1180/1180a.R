library(oce)
library(testthat)
data(sealevel)

standard <- c("Z0", "SA", "SSA", "MSM", "MM", "MSF", "MF", "ALP1", "2Q1",
              "SIG1", "Q1", "RHO1", "O1", "TAU1", "BET1", "NO1", "CHI1", "PI1",
              "P1", "S1", "K1", "PSI1", "PHI1", "THE1", "J1", "SO1", "OO1",
              "UPS1", "OQ2", "EPS2", "2N2", "MU2", "N2", "NU2", "GAM2", "H1",
              "M2", "H2", "MKS2", "LDA2", "L2", "T2", "S2", "R2", "K2", "MSN2",
              "ETA2", "MO3", "M3", "SO3", "MK3", "SK3", "MN4", "M4", "SN4",
              "MS4", "MK4", "S4", "SK4", "2MK5", "2SK5", "2MN6", "M6", "2MS6",
              "2MK6", "2SM6", "MSK6", "3MK7", "M8")
tide1 <- tidem(sealevel)
expect_equal(tide1[["data"]]$name, standard)

tide2 <- tidem(sealevel, constituents = c("M2", "K2"))
tide3 <- tidem(sealevel, constituents = c("standard","-M2")) 
