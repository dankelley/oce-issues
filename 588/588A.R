library(oce)
library(magrittr) # just for fun, really
d <- read.oce('050107_20130620_2245cast4.rsk')
if (!interactive()) png("588A.png")
d %>% subset(pressure > 2) %>% ctdTrim %>% ctdDecimate %>% plot
if (!interactive()) dev.off()
