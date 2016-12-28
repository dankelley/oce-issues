library(oce)
library(testthat)
data(adp)
adp[['orientation']] <- 'downward'

if (!interactive()) png("1128a.png")

par(mfrow=c(1, 2))

plot(adp, which=24, ytype="profile")
mtext("EXPECT: y axis from 40 to 10", col="magenta", adj=1)
mtext(" ytype='profile'", line=-1.2, adj=0)
usr1 <- par('usr')[3:4]

plot(adp, which=24, ytype="distance")
mtext("EXPECT: y axis from 10 to 40", col="magenta", adj=1)
mtext(" ytype='distance'", line=-1.2, adj=0)
usr2 <- par('usr')[3:4]

expect_equal(usr1, c(0.57, 45.39))
expect_equal(usr2, rev(c(0.57, 45.39)))

if (!interactive()) dev.off()
