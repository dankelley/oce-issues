library(oce)
library(testthat)
data(adp)

if (!interactive()) png("1128a.png")

par(mfrow=c(2, 2))

plot(adp, which=24, ytype="distance")
mtext("EXPECT: y 10 to 40, fastest @ top", col="magenta", adj=1, cex=0.9)
mtext(" ytype='distance'", line=-1.2, adj=0)
mtext("data(adp), 'upward' ", side=1, line=-8, adj=1)
usr1 <- par('usr')[3:4]

plot(adp, which=24, ytype="profile")
mtext("EXPECT: y 10 to 40, fastest @ top", col="magenta", adj=1, cex=0.9)
mtext(" ytype='profile'", line=-1.2, adj=0)
mtext("data(adp), 'upward' ", side=1, line=-8, adj=1)
usr2 <- par('usr')[3:4]

## Now change the dataset to get the other case
adp[['orientation']] <- 'downward'

plot(adp, which=24, ytype="distance")
mtext("EXPECT: y 10 to 40, fastest @ top", col="magenta", adj=1, cex=0.9)
mtext(" ytype='distance'", line=-1.2, adj=0)
mtext("'downward' ", side=1, line=-8, adj=1)
usr3 <- par('usr')[3:4]

plot(adp, which=24, ytype="profile")
mtext("EXPECT: y 10 to 40, fastest @ bottom", col="magenta", adj=1, cex=0.9)
mtext(" ytype='profile'", line=-1.2, adj=0)
mtext("'downward' ", side=1, line=-8, adj=1)
usr4 <- par('usr')[3:4]

if (!interactive()) dev.off()

## put these tests at the end so we get the graph for debugging
expect_equal(usr1, c(0.57, 45.39))
expect_equal(usr2, c(0.57, 45.39))
expect_equal(usr3, c(0.57, 45.39))
expect_equal(usr4, rev(c(0.57, 45.39)))

