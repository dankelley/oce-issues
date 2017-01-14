rm(list=ls())
library(oce)
data(adp)

t <- adp[['time']]
p <- adp[['pressure']]
T <- adp[['temperature']]

if (!interactive()) png('426.png')
par(mar=c(3,3,1,1))
omar <- par('mar')

par(mar=omar)
tn <- as.numeric(t)                     #need to convert posix to
                                        #numeric for rescale function
col <- oceColorsJet(100)[rescale(tn, min(tn), max(tn), 1, 100)]
drawPalette(t, col=oceColorsJet)        #drawPalette handles the posix
                                        #object ok
plot(T, p, col=col, pch=19)

if (!interactive()) dev.off()
