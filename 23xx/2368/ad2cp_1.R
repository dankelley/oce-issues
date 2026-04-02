library(oce)
file <- "/Users/kelley/Downloads/104561_20250219T093916UTC.AD2CP"
d <- read.oce(file, dataType = "bottomTrack")

pngName <- gsub(".*/(.*).AD2CP", "\\1_angles.png", file)
png(pngName, units="in", width=7, height=5,pointsize=11,res=200)
par(mfrow = c(3, 1))
oce.plot.ts(d[["time"]], d[["heading"]])
oce.plot.ts(d[["time"]], d[["pitch"]])
oce.plot.ts(d[["time"]], d[["roll"]]) 
dev.off()

pngName <- gsub(".*/(.*).AD2CP", "\\1_v.png", file)
png(pngName, units="in", width=7, height=5,pointsize=11,res=200)
par(mfrow = c(4, 1))
vLim <- range(d[["v"]])
oce.plot.ts(d[["time"]], d[["v"]][, 1], ylim=vLim)
oce.plot.ts(d[["time"]], d[["v"]][, 2], ylim=vLim)
oce.plot.ts(d[["time"]], d[["v"]][, 3], ylim=vLim)
oce.plot.ts(d[["time"]], d[["v"]][, 4], ylim=vLim)
dev.off()

# Set limit based on examination of the numbers. There are
# lots of negative distances ... HOW?
distanceLim <- c(0, 20)
pngName <- gsub(".*/(.*).AD2CP", "\\1_distance.png", file)
png(pngName, units="in", width=7, height=5,pointsize=11,res=200)
par(mfrow=c(4,1))
oce.plot.ts(d[["time"]], d[["distance"]][, 1], ylim=distanceLim)
oce.plot.ts(d[["time"]], d[["distance"]][, 2], ylim=distanceLim)
oce.plot.ts(d[["time"]], d[["distance"]][, 3], ylim=distanceLim)
oce.plot.ts(d[["time"]], d[["distance"]][, 4], ylim=distanceLim)
dev.off()

summary(d)

