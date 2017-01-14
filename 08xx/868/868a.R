library(oce)
##> if (!length(list.files(pattern="^lt.rda$"))) {
##>     l <- read.landsat('/data/archive/landsat/LC80070292014170LGN00/')
##>     lt <- landsatTrim(l, ll=c(-63.60, 44.62), ur=c(-63.55, 44.655))
##>     save(lt, file="lt.rda")
##> } else {
##>     load("lt.rda")
##> }

load("lt.rda")

if (!interactive()) png("868a.png", width=7, height=7, unit="in", res=100)
par(mfrow=c(2,2), mar=c(2,2,2,2))

plot(lt, band='terralook', mar=c(0.25,0.25,1,0.25), axes=FALSE)
mtext(lt[['time']], side=3, line=0, adj=1, cex=0.9, col='blue')
mtext("A. default", side=3, line=0, adj=0, cex=0.9)

plot(lt, band='terralook', green.f=1.9, mar=c(0.25,0.25,1,0.25), axes=FALSE)
mtext("B. green.f=1.9", side=3, line=0, adj=0, cex=0.9)

plot(lt, band='terralook', green.f=1.8, mar=c(0.25,0.25,1,0.25), axes=FALSE)
mtext("C. green.f=1.8", side=3, line=0, adj=0, cex=0.9)

plot(lt, band='terralook', green.f=1.7, mar=c(0.25,0.25,1,0.25), axes=FALSE)
mtext("D. green.f=1.7", side=3, line=0, adj=0, cex=0.9)

if (!interactive()) dev.off()

