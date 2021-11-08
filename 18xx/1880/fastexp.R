# For the Barnes algorithm, we have exp(-distance^2), which is always exp(x)
# where x <= 0.
#
# Idea: write e.g.  exp(-5.1) as exp(-6) * exp(0.9),
# and use lookup table for the first part, for maybe -50 to 0 or
# whatever, and then make a lookup table for the fraction part,
# which will always be put in range -1 to 0.

xf <- seq(0, 1, length.out=100)
ef <- exp(xf)

F <- list(x=xf, e=ef)


par(mfrow=c(2,1), mar=c(3,3,1,1), mgp=c(2,0.7,0))
plot(I$x, I$e, type="o", pch=20, cex=0.5)
plot(F$x, F$e, type="o", pch=20, cex=0.5)

taylor <- function(x)
{
    1 + x * (1 + x * (1/2 + x * (1/6 + x * (1/24 + x*(1/120 + x/720)))))
}

x <- seq(0, 1, length.out=100)
e <- taylor(x)
plot(x, 100*(1-e/exp(x)), type="l", ylab="Percent error")

# Integer part
xi <- seq(0, 50, 1)
ei <- exp(-xi)
print(ei, digits=15)

EXP <- function(x)
{
    i <- as.integer(floor(x))
    f <- x - i
    I <- ei[1-i]
    F <- taylor(f)
    #message("i=", i, " I=",I, " f=", f, " F=", F)
    I * F
}
x <- seq(-20, 0, length.out=1000)
E <- unlist(lapply(x, EXP))
plot(x, 100*(1-E/exp(x)), type="o", pch=20, cex=0.5, ylab="Percent error")

