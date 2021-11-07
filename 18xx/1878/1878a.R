library(oce)
if (file.exists("~/git/oce/R/section.R"))
    source("~/git/oce/R/section.R")
data(section)
debug <- 0
if (!interactive())
    png("1878a_%02d.pdf")

plot(section,which="practical salinity",debug=debug)
mtext("Is this SP (direct name)?")
plot(section,which="salinity",eos="unesco",debug=debug)
mtext("Is this SP (indirect name with eos)?")
plot(section,which="absolute salinity",debug=debug)
mtext("Is this SA (direct name)?")
plot(section,which="salinity",eos="gsw",debug=debug)
mtext("Is this SA (indirect name with eos)?")

plot(section,which="in-situ temperature",debug=debug)
mtext("Is this in-situ temperature (direct name with eos)?")

plot(section,which="conservative temperature",debug=debug)
mtext("Is this Conservative Temperature (direct name)?")
plot(section,which="potential temperature",eos="gsw",debug=debug)
mtext("Is this Conservative Temperature (indirect name with eos)?")
plot(section,which="potential temperature",eos="unesco",debug=debug)
mtext("Is this theta (direct name)?")

if (!interactive())
    dev.off()
