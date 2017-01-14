library(oce)
decimate <- 10 # speeds up by 100X and the output is cleaner, too
library(rhdf5)
file <- "~/Downloads/GMTCO-VSSTO_npp_d20160920_t0320078_e0325482_b25378_c20160924115556098849_noaa_ops.h5"
if (0 == length(ls(pattern="lon"))) { # cache
    dir <- h5ls(file)
    ## Guessing on the unit of SST. The docs suggest maybe Kelvin, but a 
    ## history of 'sst' computed next looks more oceanographic to me.
    SST <- h5read(file, "All_Data/VIIRS-SST-EDR_All/SkinSST")
    bad <- SST > 2^16-1 - 10 # top two values seem to be NA codes
    SST <- SST / 1000
    SST[bad] <- NA
    ## Lon and lat are straightforwd
    lon <- h5read(file, "All_Data/VIIRS-MOD-GEO-TC_All/Longitude")
    lat <- h5read(file, "All_Data/VIIRS-MOD-GEO-TC_All/Latitude")
    ## Time is a vector (length 192) and I don't know what that means, so I just
    ## take a mean value.  The units are weird; see page 307 of viirs-sdr-dataformat.pdf
    MidTime <- h5read(file, "All_Data/VIIRS-MOD-GEO-TC_All/MidTime", bit64conversion="double")
    t <- as.POSIXct("1958-01-01 00:00:00", tz="UTC") + mean(MidTime/1e6)
}
look <- seq(1L, length=prod(dim(SST)), by=decimate)
SST0 <- SST[look]
lon0 <- lon[look]
lat0 <- lat[look]
cm <- colormap(SST0, zlim=c(10,30))
if (!interactive()) png("1089a.png", width=800)
par(mar=c(3, 3, 1, 1))
drawPalette(colormap=cm)
plot(lon0, lat0, col=cm$zcol, pch=20, asp=1/cos(pi*mean(range(lat))/180), cex=1/3)
data(coastlineWorldMedium, package="ocedata")
lines(coastlineWorldMedium[['longitude']], coastlineWorldMedium[['latitude']])
mtext(t, side=3, line=0, adj=1)
## estimate density of data
pointPerKm <- sqrt(prod(dim(SST))) / diff(range(lat)) / 111
mtext(sprintf("~%.1fkm resolution, here decimated %dX",
              pointPerKm, decimate), side=3, line=0, adj=0)
if (!interactive()) dev.off()

