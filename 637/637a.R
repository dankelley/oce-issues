## Other tests -- take from day-previous man/colormap.Rd examples
library(oce)
try(source("~/src/oce/R/colors.R"))
cm <- colormap(x0=1:2,x1=1:2,col0=c("red","blue"),col1=c("red","blue"),debug=3)
str(cm)
stopifnot(2 == length(cm$x0))
