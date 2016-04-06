library(oce)
data(section)
stn <- section[["station", 100]]
message("\n*** SECTION ***")
STN <- handleFlags(stn, flags=list(salinity=c(1, 4:9)))

data(argo)
message("\n\n*** ARGO ***")
argoNew <- handleFlags(argo, flags=list(salinity=4:5))

