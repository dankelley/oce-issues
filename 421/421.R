d <- scan("http://www.cgd.ucar.edu/cas/catalog/climind/SOI.signal.annstd.ascii")
isYear <- d > 1800
index <- d[!isYear]
year <- 1/24 + seq(d[isYear][1], by=1/12, length.out=length(index))
## Trim -99.99 values
missing <- index < -90
year <- year[!missing]
index <- index[!missing]

## Finally, useable data
soi <- data.frame(year=year, index=index)

save(soi, file="soi.rda")
library(tools)
resaveRdaFiles("soi.rda")

par(mar=c(3, 3, 1, 1), mgp=c(2, 0.7, 0))
plot(soi$year, soi$index, type='l')
grid()


