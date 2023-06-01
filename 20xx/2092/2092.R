library(oce)
data(section)
ylim <- c(6000, 0)

if (!interactive())
    png("2092_%02d.png")

# which=data, x=longitude, with ylim
plot(section, which="data", xtype="longitude", ylim=ylim, cex=1/2, pch=20,col=2)
points(section[["longitude", "byLevel"]], section[["pressure"]], col=3, pch=1, cex=0.8)

# which=data, x=longitude, without ylim
plot(section, which="data", xtype="longitude", cex=1/2, pch=20,col=2)
points(section[["longitude", "byLevel"]], section[["pressure"]], col=3, pch=1, cex=0.8)

# which=data, x=distance (by default)
plot(section, which="data", cex=1/2, pch=20,col=2)

# four-panel types (perhaps most common)
plot(section)
plot(section, xtype="longitude")
plot(section, ztype="image")
plot(section, xtype="longitude", ztype="image")

if (!interactive())
    dev.off()


