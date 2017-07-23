library(oce)
data(section)
section <- handleFlags(section)
dhu <- swDynamicHeight(section, eos="unesco")
dhg <- swDynamicHeight(section, eos="gsw")
bad <- which(is.na(dhg$height))
if (length(bad)) {
    cat("The second of the following three stations gives NA for dyn height. Why?\n")
    for (i in bad[1] + c(-1, 1)) {
        cat("\n\n", rep("=", 100), "\n\n", sep="")
        s <- section[["station", i]]
        ##summary(s)
        ##plot(s, span=5000)
        cat("s dyn height (gsw): ", swDynamicHeight(s, eos="gsw"), "\n")
        print(data.frame(SP=s[["SP"]], t=s[["temperature"]], p=s[["pressure"]],
                         lon=s[["longitude"]], lat=s[["latitude"]],
                         SA=s[["SA"]], CT=s[["CT"]],
                         refpres=2000))
        cat("unesco gives dyn height: ", swDynamicHeight(s, eos="unesco"), "m\n")
        cat("gsw    gives dyn height: ", swDynamicHeight(s, eos="gsw"), "(converted to m)\n")
    }
}

if (!interactive()) png("1274a.png")
par(mfrow=c(2,1), mar=c(3, 3, 1, 1), mgp=c(2, 0.7, 0))
plot(dhg$distance, dhg$height)
points(dhu$distance,dhu$height,col=2)
plot(dhg$distance, dhg$height, ylim=c(-1, 3.5))
points(dhu$distance,dhu$height,col=2,pch=20)
if (!interactive()) dev.off()

