if (!interactive()) png("408.png", width=5, height=4, unit="in", res=150, type='cairo', pointsize=8)
library(oce)
data(section)
plot(section, xtype="longitude", ztype="image")
if (!interactive()) dev.off()

