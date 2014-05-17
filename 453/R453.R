if (!interactive()) png("453.png", width=7, height=4, unit="in", res=150, pointsize=9)
library(oce)
try(source("~/src/oce/R/imagep.R"), silent=TRUE)
data(topoWorld)
topoWorld@data$z[100:200, 100:200] <- NA
z <- topoWorld[['z']]
par(mfrow=c(2,2))
cm <- colormap(z, name='gmt_relief')
imagep(topoWorld, colormap=cm)
cm <- colormap(z, name='gmt_gebco')
imagep(topoWorld, colormap=cm)
cm <- colormap(z, name='gmt_ocean')
imagep(topoWorld, colormap=cm)
cm <- colormap(z, name='gmt_globe')
cm$missingColor <- "red" # new bug
imagep(topoWorld, colormap=cm)
if (!interactive()) dev.off()
