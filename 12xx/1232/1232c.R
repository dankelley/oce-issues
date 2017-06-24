library(oce)
data(section)
## This is example 3 from the update doc for plot,section-method

f <- download.topo(west=-80, east=0, south=35, north=40, resolution=4)
t <- read.topo(f)

if (!interactive()) png("1232c.png", width=7, height=5, unit="in", res=150, pointsize=10)
plot(section, which="SA", xtype="longitude", ztype="image", showBottom=t)
if (!interactive()) dev.off()

