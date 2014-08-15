if (!interactive()) png("521A.png", width=700, height=700, pointsize=12)
library(oce)
try({
    source('~/src/oce/R/drifter.R')
})
data(drifter)

par(mfrow=c(2,2))
plot(drifter)
mtext("(a)", adj=1)
mtext("EXPECT: no projection", font=2, col='purple', adj=0)

plot(drifter, projection="automatic")
mtext("(b)", adj=1)
mtext("EXPECT: auto (mollweide) projection", font=2, col='purple', adj=0)

plot(drifter, projection="+proj=merc")
mtext("(c)", adj=1)
mtext("EXPECT: mercator projection", font=2, col='purple', adj=0)

plot(drifter, projection="mercator", orientation=c(90, -60, 0))
mtext("(d)", adj=1)
mtext("EXPECT: similar to (c)", font=2, col='purple', adj=0)

if (!interactive()) dev.off()

