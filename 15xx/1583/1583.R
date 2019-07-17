library(oce)
data(section)
gs <- subset(section, 115<=stationId&stationId<=125)

## NOTE: by=1 produces all NA values in the resultant gsBarnes. But if
## we also set xr=10, then things work. Or, we can set by=2 and it works.
## xgrid <- seq(0, ceiling(max(gs[['distance', 'byStation']])), by = 1) # fails to plot
xgrid <- seq(0, ceiling(max(gs[['distance', 'byStation']])), by = 1) # fails to plot
##xgrid <- seq(0, ceiling(max(gs[['distance', 'byStation']])), by = 2) # plots OK
ygrid <- seq(5, ceiling(max(gs[['pressure']])), by = 50) # c. 100 points
gsBarnes <- sectionSmooth(gs, "barnes", xg = xgrid, yg = ygrid, xr=10, debug = 3)

par(mfrow=c(2,1))
plot(gs, eos='unesco', which="temperature")
plot(gsBarnes, eos='unesco', which="temperature")

