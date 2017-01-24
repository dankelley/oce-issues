library(oce)
data(sealevelTuktoyaktuk)
tide <- tidem(sealevelTuktoyaktuk)

tide <- tidem(sealevelTuktoyaktuk, constituents = c("M2", "K2"))

tide <- tidem(sealevelTuktoyaktuk, constituents = c("standard","-M2")) 
