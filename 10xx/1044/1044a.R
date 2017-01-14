library(oce)
if (1 == length(list.files(pattern="LADCPall.rda", path="/data/flemishCap/LADCP"))) {
    load("/data/flemishCap/LADCP/LADCPall.rda")
    s <- as.section(ladcp[2:14]) # a west-east transect
    if (!interactive()) png("1044a_%d.png")
    plot(s, which=c("u","v","temperature","salinity"), ztype='image')
    sg <- sectionGrid(s, p="levitus") # need second arg to prevent VERY slow work
    sgs <- sectionSmooth(sg, method="barnes", xgl=50, ygl=50, xr=50, yr=100)
    plot(sg, which=c("u","v","temperature","salinity"), ztype='image')
    if (!interactive()) dev.off()
}
