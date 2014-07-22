if (!interactive()) png("484_%d.png", width=7, height=7, unit="in", res=150, pointsize=12)
library(oce)
try({
    source("~/src/oce/R/landsat.R")
    source("~/src/oce/R/imagep.R")
})
if (!exists("l")) { # cache if rerunning interactively
    system.time(l <- read.landsat('~/google_drive/LC80080292014065LGN00', band='pan'))
}
## below are some tests of new indexing scheme
##    d <- l[["pan", 10]]
##    d <- l[["pan", TRUE]]
system.time(plot(l))
system.time(plot(l, decimate=200)) # really blocky so can see if worked
## Next will probably choke a 4GB machine but it's OK on an 8GB machine
## plot(l, decimate=FALSE) #very fine
if (!interactive()) dev.off()

