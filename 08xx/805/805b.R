rm(list=ls())
fraction <- 0.5
fin <- par('fin')
pin <- par('pin')
cin <- par('cin')
## small fractions yield figure margin errors
width <- fin[1]*0.5 # EXPERIMENT: adjust this

m <- 0.75                              # main margins
left <- (fin[1] - width)
par(mai=c(m, left, m, m))
plot(0:1, 0:1, type='n', xlab="palette x", ylab="pallete y")

par(new=TRUE)
par(mai=c(m,m,m,fin[1]-left))
plot(c(0,10), c(0,10), type='n', xlab="main x", ylab="main y")
box()
y <- 0.5
dy <- 1
x <- 0.25
mai <- par('mai')
text(x, y, sprintf("fin: %.2f %.2f in", fin[1], fin[2]),pos=4); y <- y + dy
text(x, y, sprintf("width: %.2f in", width),pos=4); y <- y + dy
text(x, y, sprintf("fraction: %.2f", fraction),pos=4); y <- y + dy
text(x, y, sprintf("cin: %.2f %.2f", cin[1], cin[2]),pos=4); y <- y + dy
text(x, y, sprintf("mai: %.2f %.2f %.2f %.2f in", mai[1], mai[2], mai[3], mai[4]), pos=4); y <- y + dy
## text(x, y, sprintf("pin: %.2f %.2f in", pin[1], pin[2])); y <- y + dy
