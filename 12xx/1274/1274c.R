library(oce)
data(section)
## some wild points are flagged (they yield dramatic density inversions)
section <- handleFlags(section)
## remove e.g. an odd "profile" that's got 3 or 4 levels, all below 4km

if (!interactive()) png("1274c.png")
par(mfrow=c(3,1), mar=c(3, 3, 2, 1), mgp=c(2, 0.7, 0))

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

section <- subset(section, length(pressure)>5)
dhu <- swDynamicHeight(section, eos="unesco")
dhg <- swDynamicHeight(section, eos="gsw")
plot(dhg$distance, dhg$height)
points(dhu$distance,dhu$height,col=2)
odd <- which(dhg$height < 0.5)
if (length(odd) > 1) {
    mtext(paste("nearly zero stations: ", paste(odd, collapse=" ")), side=3, line=0.2)
    odd1 <- odd[1]
    for (i in odd1 + 0*c(-1, 0, 1)) {
        stnodd <- section[["station", i]]
        cat("station ", i, " with name='", stnodd[["station"]], "'\n", sep="")
        SA <- stnodd[["SA"]]
        CT <- stnodd[["CT"]]
        p <- stnodd[["pressure"]]
        dh <- gsw::gsw_geo_strf_dyn_height(SA, CT, p)
        cat("dh= ", paste(dh, collapse=" "), "\n")
        print(data.frame(SA,CT,p,dh))
        plot(stnodd1)
    }
}

if (!interactive()) dev.off()

