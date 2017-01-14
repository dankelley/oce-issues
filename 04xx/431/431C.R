OLD <- FALSE
## Demonstrate two different colormaps.  
## Q: is this two-stage process too cumbersome?

library(oce)
data(topoWorld)
if (!interactive()) png("431C.png")

if (OLD) { # code before the "Colormap" renaming to "colormap".
    ## Set up colormaps and then -- well, what to call 'c1' and 'c2'?  Possibly
    ## call them colorscheme, in which case perhaps colorize() should be named
    ## colorScheme()???
    c1 <- colorize(colormap='gmt_relief')
    cm2 <- colormap('http://www.beamreach.org/maps/gmt/share/cpt/GMT_globe.cpt')
    c2 <- colorize(colormap=cm2)

    par(mfrow=c(2,1))
    imagep(topoWorld, breaks=c1$breaks, col=c1$col)
    imagep(topoWorld, breaks=c2$breaks, col=c2$col)
} else {
    cm1 <- colormap(name='gmt_relief')
    cm2 <- colormap(name='http://www.beamreach.org/maps/gmt/share/cpt/GMT_globe.cpt')
    par(mfrow=c(2,1))
    imagep(topoWorld, breaks=cm1$breaks, col=cm1$col)
    mtext("EXPECT: correct coastline in Hudson's Bay", font=2, col="purple")
    imagep(topoWorld, breaks=cm2$breaks, col=cm2$col)
}
if (!interactive()) dev.off()

