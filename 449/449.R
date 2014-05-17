if (!interactive()) png("449.png", width=7, height=4, unit="in", res=150, pointsize=9)

library(oce)
try(source('~/src/oce/R/colors.R'), silent=TRUE)
data(adp)
t <- adp[['time']]
p <- adp[['pressure']]
par(mfcol=c(2,2), mar=c(3, 3, 1, 1))

omar <- par('mar')

cm1 <- colormap(p, breaks=seq(39, 40, 0.1), debug=3)
stopifnot(!any(is.na(cm1$zcol)))
drawPalette(colormap=cm1)
plot(t, p, type='p', pch=21, cex=1.5, bg=cm1$zcol) 
abline(h=c(39, 40))
mtext("TEST 1 (zclip=FALSE)", side=3)

par(mar=omar)
cm2 <- colormap(p, zlim=c(39, 40), debug=3)
stopifnot(!any(is.na(cm2$zcol)))
drawPalette(colormap=cm2, debug=4)
plot(t, p, type='p', pch=21, cex=1.5, bg=cm2$zcol) 
abline(h=c(39, 40))
mtext("TEST 2 (zclip=FALSE)", side=3)

par(mar=omar)
cm3 <- colormap(p, breaks=seq(39, 40, 0.1), zclip=TRUE, debug=3)
stopifnot(!any(is.na(cm3$zcol)))
drawPalette(colormap=cm3)
plot(t, p, type='p', pch=21, cex=1.5, bg=cm3$zcol) 
abline(h=c(39, 40))
mtext("TEST 3 (zclip=TRUE)", side=3)

par(mar=omar)
cm4 <- colormap(p, zlim=c(39, 40), zclip=TRUE, debug=3, missingColor='pink')
stopifnot(!any(is.na(cm4$zcol)))
drawPalette(colormap=cm4)
plot(t, p, type='p', pch=21, cex=1.5, bg=cm4$zcol) 
abline(h=c(39, 40))
mtext("TEST 4 (zclip=TRUE)", side=3)

if (!interactive()) dev.off()

## message("CR: problem in colors (and colorbars) in tests 2 and 4 though -- it
##         spans the whole range of the data rather than the specified zlim.")
## 
## message("CR: tests 1 and 2 should look identical, as should tests 3 and 4
##         (except for the pink).")
## 
## message("CR: error in grey dots near p=40 (at the beginning of the series) in
##         test 1")

