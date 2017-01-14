library(oce)
library(marmap)

toread <- c("042.cnv","041.cnv","040.cnv")
ctds <- vector("list", length(toread))
for ( i in 1:length(toread)) {
  ctds[[i]] <- ctdDecimate(ctdTrim(read.ctd.sbe(file.path(toread[i]))),p=1)
  ## ctds[[i]][["waterDepth"]] <- max(ctds[[i]][["pressure"]]) + 10 # FAKE a bottom
}

lon <- unlist(lapply(ctds, function(x) mean(head(x[['longitude']], 20), na.rm=TRUE)))
lat <- unlist(lapply(ctds, function(x) mean(head(x[['latitude']], 20), na.rm=TRUE)))
bathy <- getNOAA.bathy(min(lon)-1, max(lon)+1, min(lat)-1, max(lat)+1, 
                       resolution = 1, keep=TRUE)
depth <- get.depth(bathy, lon, lat, locator=FALSE)

for ( i in 1:length(toread)) {
  ctds[[i]][["waterDepth"]] <- abs(depth[i,3])
}

sec1 <- as.section(ctds)
summary(sec1)
if (!interactive())
  png("1001c.png", type="cairo")
plot(sec1,
     which="temperature",
     ##which=c("temperature","salinity2","oxygen2","map"),
     xtype='distance',ztype='image', showStations=TRUE)
if (!interactive())
  dev.off()
