library(oce)
header <- function(msg) {
    cat(rep("=", 50), "\n", sep="")
    cat(msg, "\n")
    cat(rep("=", 50), "\n", sep="")
}

if (!interactive()) png("1317a_%d.png")

header("Case 1")
u1 <- "http://www.usgodae.org/ftp/outgoing/argo/dac/meds/4901783/4901783_prof.nc"
f1 <-  gsub("^.*/(.*)$", "\\1", u1)
if (0 == length(list.files(pattern=f1)))
    download.file(u1, f1)
a1 <- read.oce(f1)
##str(a1[['data']])
plot(a1, which=4)
a1s <- subset(argoGrid(a1), pressure > 500 & pressure < 1000)
##str(a1s[['data']])

header("Case 2")
u2 <- "ftp://ftp.ifremer.fr/ifremer/argo/dac/bodc/6900388/6900388_prof.nc"
f2 <-  gsub("^.*/(.*)$", "\\1", u2)
if (0 == length(list.files(pattern=f2)))
    download.file(u2, f2)
a2 <- read.oce(f2)
##str(a2[['data']])
plot(a2, which=4)
a2s <- subset(argoGrid(a2), pressure > 500 & pressure < 1000)
## str(a2s[['data']])


header("Case 3")
data(argo)
plot(argo)
plot(subset(argo, time > mean(time)))
plot(subset(argo, longitude > mean(longitude)))
argog <- argoGrid(argo)
argogs <- subset(argog, pressure > 500 & pressure < 1000)
plot(argogs, which=5) # fails

if (!interactive()) dev.off()
