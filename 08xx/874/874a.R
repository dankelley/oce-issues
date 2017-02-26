library(oce)
if (0 == length(ls(pattern="^l$")))
    l <- read.landsat("/data/archive/landsat/LC80080292014065LGN00")
##system.time(l <- read.landsat("/data/archive/landsat/LC80080292014065LGN00", decimate=10)) # u 15.2 s 3.8 e 19.0
##system.time(ldd <- read.landsat("/data/archive/landsat/LC80080292014065LGN00", decimate=50)) # u 15.4 s 4.7 e 20.5
##system.time(l  <- read.landsat("/data/archive/landsat/LC80080292014065LGN00")) # u 52.1 s 5.3 e 57.2

summary(l)
ll <- list(longitude=-63.8, latitude=44.4)
ur <- list(longitude=-63.4, latitude=44.7)
lt <- landsatTrim(l, ll, ur)
save(lt, file="lt.rda")
lt <- l
if (!interactive()) png("874a.png")
plot(lt)
plot(lt, band='terralook')
if (!interactive()) dev.off()

