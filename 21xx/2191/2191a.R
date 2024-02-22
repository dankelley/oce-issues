library(oce)
data(section)
section <- subset(section, longitude < (-72)) # speeds up tests
if (!interactive()) {
    png("2191a_%02d.png")
}
plotNumber <- 1
if (requireNamespace("ncdf4")) {
    f <- download.topo(west = -80, east = 0, south = 35, north = 40, resolution = 4)
    t <- read.topo(f)
    for (xtype in c("distance", "longitude")) {
        for (ytype in c("pressure", "depth")) {
            for (ztype in c("points", "contour", "image")) {
                for (showBottom in list(TRUE, FALSE, "polygon", "lines", "points", "topo-object")) {
                    if (showBottom == "topo-object") {
                        plot(section,
                            which = "CT",
                            xtype = xtype, ytype = ytype, ztype = ztype,
                            showBottom = t
                        )
                    } else {
                        plot(section,
                            which = "CT",
                            xtype = xtype, ytype = ytype, ztype = ztype,
                            showBottom = showBottom
                        )
                    }
                    conditions <- sprintf(
                        "xtype=%s, ytype=%s, ztype=%s, showBottom=%s",
                        xtype, ytype, ztype, showBottom
                    )
                    mtext(conditions, line = 0.5)
                    message("plotNumber=", plotNumber, ": ", conditions)
                    plotNumber <- plotNumber + 1
                }
            }
        }
    }
}
if (!interactive()) {
    dev.off()
}
