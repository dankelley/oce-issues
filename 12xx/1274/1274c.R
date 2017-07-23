library(oce)
data(section)
## some wild points are flagged (they yield dramatic density inversions)
section <- handleFlags(section)

if (!interactive()) png("1274c.png")
par(mfrow=c(2,1), mar=c(3, 3, 2, 1), mgp=c(2, 0.7, 0))

dhu <- swDynamicHeight(section, eos="unesco")
dhg <- swDynamicHeight(section, eos="gsw")
plot(dhg$distance, dhg$height)
points(dhu$distance,dhu$height,col=2)
mtext("all data", side=3, line=0.2)

section <- subset(section, min(pressure)<50)
dhu <- swDynamicHeight(section, eos="unesco")
dhg <- swDynamicHeight(section, eos="gsw")
plot(dhg$distance, dhg$height)
points(dhu$distance,dhu$height,col=2)
mtext("remove stations where top point is under 50dbar", side=3, line=0.2)

if (!interactive()) dev.off()

