## Advice to Lorena: decide upon a good storage scheme, and stick to it. If you change the
## scheme, you'll need to change all your R code, and quite soon things can get very
## confusing.
##
## Q1 for Lorena: what is the column named SBE43?
##
## Q2 for Lorena: did you mix up salinity and fluorescence?
library(oce)
library(readxl)
a <- read_excel("lorena2.xlsx", sheet=1, col_names=TRUE, col_types=NULL, na="", skip=0)
a$t <- ISOdatetime(a$year, a$month, a$day, 0, 0, 0, tz="UTC")

## This split-first method is awkward and I don't recommend it. It's just
## following some steps already taken. I do not know know what the issue
## reporter wants.

## as = a, split up by time
as <- split(a, factor(a$t))
n <- length(as) # number of distinct days
d <- vector("list", n)
profiles <- vector("list", n)
for (iday in 1:n) {
    ## PROBLEM: The previous xls file had different names for salinity and pressure
    ## PROBLEM: I think "salinity" is actually fluorescence, and "Fluorescence" is actually salinity.
    d[[iday]] <- as.ctd(as[[iday]]$Fluorescence, as[[iday]]$temperature, as[[iday]]$pressure)
    d[[iday]] <- oceSetData(d[[iday]], "oxygen", as[[iday]]$Oxygensat)
    d[[iday]] <- oceSetData(d[[iday]], "fluorescence", as[[iday]]$salinity)
    ## The previous xls file lacked longitude and latitude
    d[[iday]] <- oceSetData(d[[iday]], "longitude", as[[iday]]$longitude)
    d[[iday]] <- oceSetData(d[[iday]], "latitude", as[[iday]]$latitude)
    profiles[[iday]] <- ctdFindProfiles(d[[iday]])
}

## plot all profiles
if (!interactive()) png("1206a_profiles_%02d.png")
for (iday in 1:n) {
    for (j in seq_along(profiles[[iday]]))
        plot(profiles[[iday]][[j]])
}
if (!interactive()) dev.off()


if (!interactive()) png("1206a_sections_%02d.png")
par(mfrow=c(2, 1))
## NOTE: I'm using a lot of levels to see patterns below the first 20m
for (iday in 1:n) {
    sec <- as.section(profiles[[iday]])
    plot(sec, which="temperature", nlevel=20)
    dist <- geodDist(sec)
    axis(3, at=dist, label=seq_along(dist)) # shows how to add things at top
    plot(sec, which="fluorescence", nlevel=20)
    dist <- geodDist(sec)
    axis(3, at=dist, label=seq_along(dist)) # shows how to add things at top
}
if (!interactive()) dev.off()

