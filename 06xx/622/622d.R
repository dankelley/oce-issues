library(oce)

if (!interactive()) png("622d_%d.png")

## CASE 1: pressure should start at about 0
d <- read.rsk("a.rsk", patm=TRUE)
plot(ctdTrim(d))
cat("note that waterDepth is wrong")
summary(d)
stopifnot(min(d[["pressure"]]) < 1)

## CASE 2: pressure should start at about 10.3
d <- read.rsk("a.rsk", patm=FALSE)
plot(ctdTrim(d))
cat("note that waterDepth is wrong")
summary(d)
stopifnot(min(d[["pressure"]]) > 9)

## CASE 3: pressure should start at about 10.3
d <- read.rsk("a.rsk")
plot(ctdTrim(d))
cat("note that waterDepth is wrong")
summary(d)
stopifnot(min(d[["pressure"]]) > 9)

## CASE 4: pressure should start at about 10.3
d <- read.rsk("a.rsk")
plot(ctdTrim(d))
summary(d)
p <- d[["pressure"]]
S <- d[["salinity"]]

## CASE 5: pressure should start at about 10.3
d <- read.rsk("a.rsk", patm=FALSE)
plot(ctdTrim(d))
summary(d)
stopifnot(all.equal(d[["pressure"]], p))
stopifnot(all.equal(d[["salinity"]], S))

## CASE 6: pressure should start near 0 dbar
d <- read.rsk("a.rsk", patm=TRUE)
plot(ctdTrim(d))
summary(d)
stopifnot(all.equal(d[["salinity"]], S))

## CASE 7: salinity should be slightly different from above
d <- read.rsk("a.rsk", patm=10)
summary(d)
