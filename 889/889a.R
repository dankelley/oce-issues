library(oce)
x <- 1:10
y <- 1:10
u <- rep(0.25, 10)
v <- u
dy <- 0.5

if (!interactive()) png("889a.png")

drawDirectionField(x, y, u, v, scalex=1, type=1)

drawDirectionField(x, y, u, v, scalex=1, type=1)
y <- y + dy
drawDirectionField(x, y, u, v, scalex=1, type=1, add=TRUE, length=0.1, col='red')
y <- y + dy
drawDirectionField(x, y, u, v, scalex=1, type=1, add=TRUE, length=0.025, col='blue')
y <- y + dy
drawDirectionField(x, y, u, v, scalex=1, type=2, add=TRUE)
y <- y + dy
drawDirectionField(x, y, u, v, scalex=1, type=2, add=TRUE, length=0.1, col='red')
y <- y + dy
drawDirectionField(x, y, u, v, scalex=1, type=2, add=TRUE, length=0.025, col='blue')
y <- y + dy

if (!interactive()) dev.off()

