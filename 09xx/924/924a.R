library(oce)
d <- read.oce(system.file("extdata", "d201211_0011.cnv", package="oce"))

## The following is in the .cnv file:
# Processing Notes:  Flag word has 3 columns: Temperature, Conductivity, and Oxygen
# Processing Notes:  Flag_code:  0 = no QC; 2 = good; 6 = interpolated, or replaced by dual sensor or upcast value;

flag <- d[['flag']]
flag1 <- floor(flag/100)
flag2 <- floor((flag-100*flag1)/10)
flag3 <- floor((flag-100*flag1-10*flag2))
print(d[["flags"]])
d[["flags"]]$temperature <- flag1
d[["flags"]]$conductivity <- flag2
d[["flags"]]$oxygen <- flag3
print(d[["flags"]])

