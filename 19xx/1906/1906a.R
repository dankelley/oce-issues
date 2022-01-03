library(oce)
data(section)

#source("~/git/oce/R/section.R")
#source("~/git/oce/R/misc.R")
#source("~/git/oce/R/ctd.R")

stn <- section[["station", 100]]
data(section)
stn <- section[["station", 100]]
p <- stn[["pressure"]]
T <- stn[["temperature"]]
S <- stn[["salinity"]]

png("1906a_%02d.png", width=700, height=300)
par(mfrow=c(1, 2))
# 1. Check temperature
plotProfile(stn, xtype="temperature",type="p") # docs say in-situ
lines(T,p,col=2)
text(6,2500,"Line should go\nthrough circles;\npanels should be\nidentical.",pos=4)
plot(stn,which="temperature")
lines(T,p,col=2)
text(6,2500,"Line should go\nthrough circles;\npanels should be\nidentical.",pos=4)

# 2. Check salinity
plotProfile(stn, xtype="salinity", type="p")
lines(S,p,col=2)
text(35.2,2500,"Line should go\nthrough circles;\npanels should be\nidentical.",pos=4)
plot(stn,which="salinity")
lines(S,p,col=2)
text(35.2,2500,"Line should go\nthrough circles;\npanels should be\nidentical.",pos=4)

# 3. Examine all possibilities
q <- stn[["?"]]
print(q)
for (item in sort(c(q$data, q$dataDerived))) {
    message(item)
    plot(stn, which=item)
    mtext(paste0(" which=",item),side=1,line=-1.0,col=2,font=2,cex=par("cex"))
}

dev.off()

