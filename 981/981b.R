library(oce)
try(source("~/src/oce/R/section.R"))
try(source("~/src/oce/R/ctd.R"))
try(source("~/src/oce/R/misc.R"))

data(section)

if (!interactive()) png("981b.png")

par(mfrow=c(1,2))

## 1 umol/kg = 1 nmol/g

plot(section, which="silicate")
mtext("Note the unit ", side=3, line=0.5, adj=1, col='magenta', font=2, cex=2/3)
for (i in seq_along(section@data$station)) {
    section@data$station[[i]]@metadata$units$silicate <- list(unit=expression(nmol/g), scale="")
}
plot(section, which="silicate")
mtext("The unit should now be nmol/g ", side=3, line=0.5, adj=1, col='magenta', font=2, cex=2/3)
if (!interactive()) dev.off()
