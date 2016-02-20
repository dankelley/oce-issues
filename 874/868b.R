library(oce)
if (!length(list.files(pattern="^l2t.rda$"))) {
    l2 <- read.landsat("/data/archive/landsat/LC80080292014065LGN00")
    l2t <- landsatTrim(l2, ll=c(-63.60, 44.62), ur=c(-63.55, 44.655))
    save(l2t, file="l2t.rda")
} else {
    load("l2t.rda")
}

lt <- l2t

red.f <- 2
blue.f <- 6

if (!interactive()) png("868b.png", width=7, height=7, unit="in", res=100)
par(mfrow=c(2,2), mar=c(2,2,2,2))

plot(lt, band='terralook', mar=c(0.25,0.25,1,0.25), axes=FALSE)
mtext(lt[['time']], side=3, line=0, adj=1, cex=0.9, col='blue')
mtext("A. default", side=3, line=0, adj=0, cex=0.9)

plot(lt, band='terralook', green.f=1.9, red.f=red.f, blue.f=blue.f,
     mar=c(0.25,0.25,1,0.25), axes=FALSE)
mtext("B. green.f=1.9", side=3, line=0, adj=0, cex=0.9)

plot(lt, band='terralook', green.f=1.8, red.f=red.f, blue.f=blue.f,
     mar=c(0.25,0.25,1,0.25), axes=FALSE)
mtext("C. green.f=1.8", side=3, line=0, adj=0, cex=0.9)

plot(lt, band='terralook', green.f=1.7, red.f=red.f, blue.f=blue.f,
     mar=c(0.25,0.25,1,0.25), axes=FALSE)
mtext("D. green.f=1.7", side=3, line=0, adj=0, cex=0.9)

if (!interactive()) dev.off()

