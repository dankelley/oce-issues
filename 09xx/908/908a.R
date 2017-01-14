rm(list=ls())
library(oce)
data(section)

if (!interactive()) png('907a.png')
plot(section, which='temperature', xtype='time')
if (!interactive()) dev.off()
