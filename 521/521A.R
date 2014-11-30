if (!interactive()) png("521A.png", width=700, height=700, pointsize=12)
library(oce)
try({
    source('~/src/oce/R/drifter.R')
    source('~/src/oce/R/map.R')
})
data(drifter)

par(mfrow=c(2,2))
plot(drifter)
mtext("no projection", adj=1)

p <- "automatic"
plot(drifter, projection=p, fill="lightgray")
mtext(p, adj=1)
mtext("EXPECT: auto (mercator) projection", font=2, col='purple', adj=0)

p <- "+proj=merc"
plot(drifter, projection=p, fill="lightgray")
mtext(p, adj=1)

p <- "mercator"
plot(drifter, projection=p, fill=FALSE)
mtext(p, adj=1)
mtext("EXPECT: as at left but no fill", font=2, col='purple', adj=0)
mtext("BUG: horiz. lines; cannot fill", font=2, col='purple', adj=0, line=1)

if (!interactive()) dev.off()

