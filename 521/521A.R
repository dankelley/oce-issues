if (!interactive()) png("521A.png", width=700, height=700, pointsize=12)
library(oce)
try({
    source('~/src/oce/R/drifter.R')
    source('~/src/oce/R/map.R')
})
data(drifter)

par(mfrow=c(2,2))
plot(drifter)
mtext("(a)", adj=1)
mtext("EXPECT: no projection", font=2, col='purple', adj=0)

plot(drifter, projection="automatic", fill="lightgray")
mtext("(b)", adj=1)
mtext("EXPECT: auto (mercator) projection", font=2, col='purple', adj=0)

plot(drifter, projection="+proj=merc", fill="lightgray")
mtext("(c)", adj=1)
mtext("EXPECT: mercator projection", font=2, col='purple', adj=0)

plot(drifter, projection="mercator", fill=FALSE)
mtext("(d)", adj=1)
mtext("EXPECT: similar to (c) but no fill", font=2, col='purple', adj=0)
mtext("BUG: horiz. lines; cannot fill", font=2, col='purple', adj=0, line=1)

if (!interactive()) dev.off()

