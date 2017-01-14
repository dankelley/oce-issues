library(gsw)
SA <- gsw_SA_from_SP(SP=35, p=1000, longitude=300, latitude=30)
message("gsw direct:", gsw_CT_from_t(SA=SA, t=10, p=1000), "\n")
library(oce)
message("oce: ", swTheta(35,10,1000,eos="gsw"), "\n")
message("oce: ", swTheta(35,10,1000,lon=300,lat=30,eos="gsw"), "\n")

