library(oce)
data(section)
stn <- section[["station", 100]]
message("\n*** SECTION ***")
## this stn has a few points with salinityFlag==3
STN <- handleFlags(stn, flags=list(salinity=c(1, 3:9)))
print(data.frame(oldS=stn[['salinity']], flag=stn[['salinityFlag']], new=STN[['salinity']]))

data(argo)
message("\n\n*** ARGO ***")
argoNew <- handleFlags(argo, flags=list(salinity=4:5))

