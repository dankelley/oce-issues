if (!interactive()) png("485.png", width=7, height=4, unit="in", res=100)
library(oce)
try({
    source('~/src/oce/R/landsat.R')
    source('~/src/oce/R/imagep.R')
})
data(landsat, package='ocedata')
par(mfrow=c(1,2))
plot(landsat)
mtext("EXPECT: RHS value zoomed to water", font=2, col="purple", side=1, line=2)
plot(landsat, breaks=seq(16500, 18000, 10))
if (!interactive()) dev.off()

