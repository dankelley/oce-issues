library(oce)
library(gsw)
data(ctd)
SA1<-ctd[["SA"]]
SA2<-ctd[["SA/gsw"]]
CT1<-ctd[["CT"]]
CT2<-ctd[["CT/gsw"]]
message("following should be small: ", sum(abs(SA1-SA2)))
message("following should be small: ", sum(abs(CT1-CT2)))

