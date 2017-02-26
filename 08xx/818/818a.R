library(oce)
data(argo)
## fake some data
degF <- 32+(9/5)*argo[['temperature']]
argo2 <- oceSetData(argo, "degF", degF, unit=list(unit=expression(degree*F), scale="ITS-90"))

sec <- as.section(argo2)
if (!interactive()) png("818a.png")
par(mfrow=c(2,1))
plot(sec, which="temperature", ylim=c(2000,0))
mtext("EXPECT: bottom panel labelled 'degF'", side=3, line=0.5, font=2, col="magenta", adj=0)
plot(sec, which="degF", ylim=c(2000,0))
if (!interactive()) dev.off()

summary(sec[["station", 1]]) # check units by eye

