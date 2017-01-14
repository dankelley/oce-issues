if (!interactive()) png("390A.png")
library(oce)
data(adp)
par(mfrow=c(2,1))
u <- adp[['v']][,,1]
maxvalue <- max(abs(range(u, na.rm = TRUE)))
zlims <- c(-maxvalue, maxvalue)
imagep(u, zlim=zlims)
mtext("EXPECT: (not sure--any idea, @richardsc?)", font=2, col="purple")

zlims <- c(-1.11, 1.11)
imagep(u, zlim=zlims)
mtext("EXPECT: (not sure--any idea, @richardsc?)", font=2, col="purple")

if (!interactive()) dev.off()
