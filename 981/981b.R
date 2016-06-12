library(oce)
try(source("~/src/oce/R/misc.R"))
try(source("~/src/oce/R/ctd.R"))

data(section)

if (!interactive()) png("981b.png")

par(mfrow=c(1,2))

## 1 umol/kg = 1 nmol/g
unitFake <- list(unit=expression(nmol/g), scale="")

plot(section, which="silicate")

plot(section, which="silicate")
mtext("Expect nmol/g ", side=3, line=-1, adj=1, col='magenta', font=2, cex=2/3)
if (!interactive()) dev.off()
