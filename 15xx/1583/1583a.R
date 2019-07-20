library(oce)
data(section)
gs <- subset(section, 115<=stationId&stationId<=125)

if (!interactive()) png("1583a.png")
par(mfrow=c(3,1))

plot(gs, eos='unesco', which="temperature", debug=3)
mtext("gs",cex=0.8,line=0.5)

xgrid1 <- seq(0, ceiling(max(gs[['distance', 'byStation']])), by = 1)
ygrid <- seq(0, ceiling(max(gs[['pressure']])), by = 20) # c. 200 points
gsBarnes1 <- sectionSmooth(gs, "barnes", xg = xgrid1, yg = ygrid, debug=3)
plot(gsBarnes1, eos='unesco', which="temperature", debug=3)
mtext("gsBarnes1 by=1km",cex=0.8,line=0.5)

xgrid2 <- seq(0, ceiling(max(gs[['distance', 'byStation']])), by = 2)
gsBarnes2 <- sectionSmooth(gs, "barnes", xg = xgrid2, yg = ygrid, debug=3)
ygrid <- seq(0, ceiling(max(gs[['pressure']])), by = 20) # c. 200 points
plot(gsBarnes2, eos='unesco', which="temperature", debug=3)
mtext("gsBarnes2 by=2km",cex=0.8,line=0.5)

if (!interactive()) dev.off()
