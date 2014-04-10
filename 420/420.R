d <- scan("http://www.cpc.ncep.noaa.gov/products/precip/CWlink/pna/norm.nao.monthly.b5001.current.ascii.table")
isYear <- d > 1900
index <- d[!isYear]
year <- 1/24 + seq(d[isYear][1], by=1/12, length.out=length(index))
nao <- data.frame(year=year, index=index)
save(nao, file="nao.rda")
library(tools)
resaveRdaFiles("nao.rda")

par(mar=c(3, 3, 1, 1), mgp=c(2, 0.7, 0))
plot(nao$year, nao$index, type='l')
grid()


