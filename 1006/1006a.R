library(oce)
## a <- read.oce("/Users/kelley/MEOP-CTD_2015-07-01/CANADA/ncARGO/ct55-9575-10_prof.nc")
a <- read.oce("ct55-9575-10_prof.nc")
s <- as.section(a)
plot(s, ztype='image')


