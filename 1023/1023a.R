library(oce)
f <- "/data/flemishCap/moorings/1840/Processed_RCMnew/MCM_HUD2013021_1840_0685_3600.ODF"
d <- read.odf(f)
summary(d)
cm <- as.cm(d)
summary(cm)

