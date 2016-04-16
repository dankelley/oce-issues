library(oce)
d <- read.oce(system.file("extdata", "d201211_0011.cnv", package="oce"),debug=1)
str(d[['units']])
