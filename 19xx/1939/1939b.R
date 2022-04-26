library(profvis)
profvis({
    x <- rnorm(1e4)
    y <- sin(seq_along(x/100)) + x
    plot(x,y)
    axis(side=3)
    mtext("goodbye")
})


library(profvis)
profvis({
    x <- rnorm(1e5)
    y <- sin(seq_along(x/100)) + x
    plot(x,y, type="n")
    axis(side=3)
    mtext("goodbye")
    points(x, y,col=2)
})

# Next are 2.868s and 7.973 for DEK, i.e. a speedup by a factor of 2.78. This
# is consistent with the mental model that both axis() and mtext() use time
# proportional to the time to plot the points.  This is for quartz(); I don't
# see this effect in png().
system.time({ plot(x,y, type="n");axis(side=3);mtext("goodbye");points(x, y,col=2)})
system.time({ plot(x,y);axis(side=3);mtext("goodbye")})
