library(oce)
library(ncdf4)
files <- c("025.nc", "040.nc", "047.nc")
nfiles <- length(files)
s <- vector("list", nfiles)
for (ifile in seq_along(files)) {
    message("Processing data in file '", files[ifile], "'")
    d <- nc_open(files[ifile])
    timevec <- ncvar_get(d, "date")
    time <- ISOdatetime(timevec[1],timevec[2],timevec[3],timevec[4],timevec[5],timevec[6],tz="UTC")
    ladp <- as.ladp(station=gsub(".nc", "", files[ifile]),
                    longitude=ncvar_get(d, "lon"),
                    latitude=ncvar_get(d, "lat"),
                    time=time,
                    pressure=ncvar_get(d, "p"),
                    u=ncvar_get(d, "u"),
                    v=ncvar_get(d, "v"),
                    salinity=ncvar_get(d, "ctd_s"),
                    temperature=ncvar_get(d, "ctd_t"))
    ## NB. can add extra columns in the above, if required
    s[[ifile]] <- ladp
}
sec <- makeSection(s)
sec
summary(sec)
if (!interactive()) png("648b.png")
par(mfrow=c(2,2))
plot(sec, which="salinity")
plot(sec, which="temperature")
plot(sec, which="u")
plot(sec, which="v")
if (!interactive()) dev.off()
