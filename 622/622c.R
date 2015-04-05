library(oce)

## CASE 1: pressure should start at about 10.3
d <- read.oce("a.rsk")
head(d[['pressure']])
head(d[['salinity']])
print(d[['waterDepth']])
message("note that waterDepth is wrong")
processingLogShow(d)
p <- d[["pressure"]]
S <- d[["salinity"]]

## CASE 2: pressure should start at about 10.3
d <- read.logger("a.rsk")
head(d[['pressure']])
head(d[['salinity']])
print(d[['waterDepth']])
message("note that waterDepth is wrong")
processingLogShow(d)
stopifnot(all.equal(d[["pressure"]], p))
stopifnot(all.equal(d[["salinity"]], S))

## CASE 3: pressure should start at about 10.3
d <- read.logger("a.rsk", patm=FALSE)
head(d[['pressure']])
head(d[['salinity']])
print(d[['waterDepth']])
message("note that waterDepth is wrong")
processingLogShow(d)
stopifnot(all.equal(d[["pressure"]], p))
stopifnot(all.equal(d[["salinity"]], S))

## CASE 4: pressure should start near 0 dbar
d <- read.logger("a.rsk", patm=TRUE)
head(d[['pressure']])
head(d[['salinity']])
print(d[['waterDepth']])
processingLogShow(d)
stopifnot(all.equal(d[["salinity"]], S))

## CASE 5: salinity should be slightly different from above
d <- read.logger("a.rsk", patm=10)
head(d[['pressure']])
head(d[['salinity']])
print(d[['waterDepth']])
processingLogShow(d)

