# Test a few local ODF files.  This is Dan's first test suite, since it is
# faster than 1808b.R and it covers three institutions.

# git clone https://github.com/dankelley/oce-issues.git


library(oce)
options(width=200)

# Uncomment the next lines for testing, saving the time it takes to build oce.

# source("~/git/oce/R/oce.R")
# source("~/git/oce/R/misc.R")
# source("~/git/oce/R/odf.R")
# source("~/git/oce/R/ctd.R")
# source("~/git/oce/R/ctd.odf.R")

# IML lab
diml <- read.oce("CTD_1994038_147_1_DN.ODF")
summary(diml)

# BIO lab
dbio <- read.oce("CTD_BCD2014666_008_1_DN.ODF")
summary(dbio)

# UNB? lab
dunb <- read.oce("CTD_2020003_004_1_DN.odf")
summary(dunb)

