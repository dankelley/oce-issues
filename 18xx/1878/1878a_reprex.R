library(oce)
data(section)
section <- subset(handleFlags(section), longitude > (-40))

par(mfrow=c(3,2))
for (which in c("salinity", "temperature", "SA", "CT")) {
    plot(section, which=which)
    mtext(paste0("which=\"",which,"\""), cex=par("cex"))
}
hist(section[["SA"]] - section[["salinity"]],
    main="SA-salinity contrast")
hist(section[["CT"]] - section[["temperature"]],
    main="CT-temperature contrast")

available <- section[["?"]]
names <- sort(c(available$data, available$dataDerived))
for (name in names) {
    plot(section, which=name)
    mtext(paste0("which=\"", name, "\""), line=0.5, cex=par("cex"))
}

