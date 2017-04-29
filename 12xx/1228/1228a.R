o <- 1 # the offset we need to compare (since oce is losing first ensemble)
library(R.matlab)
library(oce)
options(digits=10)
options(digits.secs=4)

m <- readMat("adcp.mat")
d <- read.oce("adcp.000")
vectorShow(d[["pressure"]], n=4)
vectorShow(m$AnDepthmm, n=4)
i <- 1:500
df <- data.frame(poce=d[["pressure"]][i], pm=m$AnDepthmm[o+i]/1000.0)
print(head(df, 40))
plot(df$poce - df$pm, type='l')
rms <- function(x,y) sqrt(mean((x-y)^2))
mtext(sprintf("sd difference for index>100: %.5f", rms(df$poce[100:200], df$pm[100:200])), side=3)

## oce misses first profile (look at the hour)
i <- 1:100
AAA <- 0.128                           # a pressure offset, guessed from data
df2 <- data.frame(ocetime=d[["time"]][i], mday=m$SerDay[i+o], mhour=m$SerHour[i+o],
                  poce=d[["pressure"]][i], pm=m$AnDepthmm[i+o]/1000.0,
                  diff=d[["pressure"]][i]-m$AnDepthmm[i+o]/1000.0-AAA)
print(df2)

