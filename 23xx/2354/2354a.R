library(oce)
beam <- read.oce("~/data/archive/sleiwex/2008/moorings/m09/adp/rdi_2615/raw/adp_rdi_2615.000",
    from = as.POSIXct("2008-06-26", tz = "UTC"),
    to = as.POSIXct("2008-06-27", tz = "UTC"),
    by = "60:00",
    testing = TRUE,
    latitude = 47.88126,
    longitude = -69.73433
)
xyz <- beamToXyzAdp(beam)
enu <- xyzToEnuAdp(xyz, declination = -18.1)
data(adp)

cat("data(adp) has heading                            ", adp[["heading"]][1:2], "...\n")
cat("BEAM computed on 2026-01-19 has heading          ", beam[["heading"]][1:2], "...\n")
cat("ENU  computed on 2026-01-19 has heading          ", enu[["heading"]][1:2], "...\n")
cat("ENU-data(adp) computed on 2026-01-19 has heading ", enu[["heading"]][1:2]-adp[["heading"]][1:2], "...\n")

