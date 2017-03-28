library(oce)
library(readxl)
a <- read_excel("lorena3.xlsx", sheet=1, col_names=TRUE, col_types=NULL, na="", skip=0)
a$t <- ISOdatetime(a$year, a$month, a$day, 0, 0, 0, tz="UTC")
#as = a, split up by time
as <- split(a, factor(a$t))
n <- length(as) # number of distinct days
d <- vector("list", n)
profiles <- vector("list", n)
for (iday in 1:n) {
  d[[iday]] <- as.ctd(as[[iday]])
  d[[iday]] <- oceSetData(d[[iday]], "oxygen", as[[iday]]$oxygensat)
  d[[iday]] <- oceSetData(d[[iday]], "fluorescence", as[[iday]]$fluorescence)
  d[[iday]] <- oceSetData(d[[iday]], "longitude", as[[iday]]$longitude)
  d[[iday]] <- oceSetData(d[[iday]], "latitude", as[[iday]]$latitude)
  profiles[[iday]] <- ctdFindProfiles(d[[iday]])
}

#plot ctd profiles
if (!interactive()) png("1206a_profiles_%02d.png")
for (iday in 1:n) {
  for (j in seq_along(profiles[[iday]]))
    plot(profiles[[iday]][[j]])
}
if (!interactive()) dev.off()


if (!interactive()) png("1206a_sections_%02d.png")
par(mfrow=c(2, 1))



#plot section
par(mfrow=c(2,2))
for (iday in 1:n) {
  sec <- as.section(profiles[[iday]])
  plot(sec, which="temperature", nlevel=20, ztype='image')
  dist <- geodDist(sec)
  axis(3, at=dist, label=seq_along(dist)) 
  title(main = iday) 
  plot(sec, which="fluorescence", nlevel=20 , ztype='image')
  dist <- geodDist(sec)
  axis(3, at=dist, label=seq_along(dist))
  title(main = iday)
} 
if (!interactive()) dev.off()
