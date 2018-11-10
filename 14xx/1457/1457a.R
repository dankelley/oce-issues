library(oce)
old <- read.oce("old.cnv")
new1 <- read.oce("new.cnv")
new2 <- read.oce("new.cnv", columns=list(conductivity=list(name="cond0S/m", unit=list(unit=expression(S/m), scale=""))))
