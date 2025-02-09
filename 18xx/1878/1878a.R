library(oce)
data(section)
section <- handleFlags(section)
# focus on the eastern region
section <- subset(section, longitude > (-40))
if (!interactive())
    png("1878a_%02d.png", unit="in", width=7, height=7, res=200)

par(mfrow=c(3,2))
for (which in c("salinity", "temperature", "SA", "CT")) {
    plot(section, which=which)
    mtext(paste0("which=\"",which,"\""), font=2)
}
hist(section[["SA"]] - section[["salinity"]],
    main="SA-salinity contrast")
hist(section[["CT"]] - section[["temperature"]],
    main="CT-temperature contrast")

available <- section[["?"]]
names <- sort(c(available$data, available$dataDerived))
for (name in names) {
    plot(section, which=name)
    mtext(paste0("which=\"", name, "\""), line=0.5, font=2)
}

if (!interactive())
    dev.off()

