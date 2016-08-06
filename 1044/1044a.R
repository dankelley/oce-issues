library(oce)
if (1 == length(list.files(pattern="LADCPall.rda", path="/data/flemishCap/LADCP"))) {
    load("/data/flemishCap/LADCP/LADCPall.rda")
    s <- as.section(ladcp[2:14]) # a west-east transect

    if (!interactive()) png("1044a.png")

    plot(s, which="v", ztype='image', zbreaks=seq(-0.5, 0.5, 0.05), zcol=oceColorsTwo)
    sg <- sectionGrid(s)
    p <- sg[['station', 1]][['pressure']]
    distance <- sg[['distance', "byStation"]]
    salinity <- matrix(sg[["salinity"]], nrow=length(distance), ncol=length(p), byrow=TRUE)
    contour(distance, p, salinity, add=TRUE)
    ## try smoothing
    sg <- sectionGrid(s, p="levitus") # need second arg to prevent VERY slow work
    sgs <- sectionSmooth(sg, method="barnes", xgl=50, ygl=50, xr=50, yr=100)
    if (!interactive()) dev.off()
}
