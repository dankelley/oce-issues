## read, then grid and plot, VIIRS data
library(oce)
decimate <- 4 # speeds up gridding
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
if (!interactive()) png("1089b_%d.png", width=800)
par(mar=c(3, 3, 1, 1))
asp <- 1/cos(pi*mean(range(lat))/180)
n <- as.integer(sqrt(length(lon)))
lonG <- pretty(lon, n/decimate)
latG <- pretty(lat, n/decimate)
for (fillgap in c(2, 4, 6)) {
    print(system.time(G <- binMean2D(lon, lat, SST, lonG, latG, fill=TRUE, fillgap=fillgap)))
    imagep(G$xmids, G$ymids, G$result, zlim=c(10,30), col=oceColorsJet, asp=asp)
    data(coastlineWorldMedium, package="ocedata")
    polygon(coastlineWorldMedium[['longitude']], coastlineWorldMedium[['latitude']], col='lightgray')
    mtext(sprintf("gridded to dlon=%.2f and dlat=%.2f fillgap=%.0f",
                  G$xmids[2]-G$xmids[1], G$ymids[2]-G$ymids[1], fillgap), side=3, line=0, adj=0)
}

if (!interactive()) dev.off()
