library(oce)
d <- read.oce("a.rsk", patm=FALSE)
message("patm=FALSE doesn't keep the presure from being corrected")
dt <- ctdTrim(d)
if (!interactive()) png("622b.png")
plot(dt)
if (!interactive()) dev.off()

