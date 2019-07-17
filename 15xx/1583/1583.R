library(oce)
data(section)
gs <- subset(section, 115<=stationId&stationId<=125)

xgrid <- seq(0, ceiling(max(gs[['distance', 'byStation']])), by = 1)
ygrid <- seq(5, ceiling(max(gs[['pressure']])), by = 5)
# Barnes
source("~/git/oce/R/section.R")
gsBarnes <- sectionSmooth(gs, "barnes", xg = xgrid, yg = ygrid, debug = 3)
