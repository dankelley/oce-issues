library(oce)
library(argoFloats)
library(testthat)
i <- getIndex()
si <- subset(i, ID=6901191)
si <- subset(si, cycle=1:10)
d <- readProfiles(getProfiles(si))

createSection <- function(argos)
{
    if (!inherits(argos, "argoFloats"))
        stop("First argument must be an argoFloats object")
    if (argos[["type"]] != "argos")
        stop("First argument must be an argoFloats object of type \"argos\"")
    oce::as.section(lapply(argos[["argos"]],
            function(a) {
                oceSetMetadata(as.ctd(a), "waterDepth", max(a[["pressure"]], na.rm=TRUE))
            }))
}

# Some salinities are 0, so the salinity and density plots are ugly.
sec3 <- createSection(d)
plot(sec3, xtype="time")

# Things look better if we restrict attention to data flagged as good.
sec4 <- createSection(applyQC(d))
plot(sec4, xtype="time")


