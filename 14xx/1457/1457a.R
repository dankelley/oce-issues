library(oce)
old <- read.oce("old.cnv")
new1 <- read.oce("new.cnv")
new2 <- read.oce("new.cnv", columns=list(conductivity=list(name="cond0S/m", unit=list(unit=expression(S/m), scale=""))))
cat(" old[['time']] starts: ", paste(old[["time"]][1:3], collapse=" "), "\n")
cat("new1[['time']] starts: ", paste(new1[["time"]][1:3], collapse=" "), "\n")
cat("new2[['time']] starts: ", paste(new2[["time"]][1:3], collapse=" "), "\n")
