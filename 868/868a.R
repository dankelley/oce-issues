library(oce)
if (!length(list.files(pattern="^lt.rda$"))) {
    l <- read.landsat('/data/archive/landsat/LC80070292014170LGN00/')
    lt <- landsatTrim(l, ll=c(-63.60, 44.62), ur=c(-63.55, 44.655))
    save(lt, file="lt.rda")
} else {
    load("lt.rda")
}

if (!interactive()) png("868a.png", width=8, height=3, unit="in", res=150)
par(mfrow=c(1,3), mar=c(2,2,2,2))
cex <- 0.8

plot(lt, band='terralook', mar=c(0.25,0.25,1,0.25), axes=FALSE, decimate=FALSE)
mtext(lt[['time']], side=3, line=0, adj=0.5, cex=cex)
mtext("A. default", side=3, line=0, adj=0, cex=cex)

## Try less green (default is 2)
plot(lt, band='terralook', green.f=1.8, mar=c(0.25,0.25,1,0.25), axes=FALSE)
mtext("B. green.f=1.8", side=3, line=0, adj=0, cex=cex)

## Try more green
plot(lt, band='terralook', green.f=2.2, mar=c(0.25,0.25,1,0.25), axes=FALSE)
mtext("C. green.f=2.2", side=3, line=0, adj=0, cex=cex)

if (!interactive()) dev.off()

