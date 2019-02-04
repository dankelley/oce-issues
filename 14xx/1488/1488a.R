library(oce)
data(ctd)
p <- ctd[['pressure']]
if (!interactive()) png("1488a.png")
par(mar=c(3, 3, 1, 1), mgp=c(2, 0.7, 0), mfrow=c(1, 2))
plot(swTFreeze(ctd, eos='unesco'), p, ylim=rev(range(p)), type='l', lwd=2)
lines(swTFreeze(ctd, eos='gsw'), p, col=2, lty=2)
legend('bottomright', c('UNESCO', 'GSW'), lty=1, col=1:2, lwd=2:1)
plot(swTFreeze(ctd,eos='unesco')-swTFreeze(ctd,eos='gsw'), p,
     ylim=rev(range(p)), type="l", xlab="Difference [degC]")
if (!interactive()) dev.off()

