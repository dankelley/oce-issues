rm(list=ls())
# 2nd demonstration of RStudio problem with margins.
#
# GOAL: create a w=0.2-inch wide plot, near right edge of plot area, with a m=0.5 inch margin
# at bottom, right, and top. Do this by setting the left-hand margin to 
# par('pin)'-w-m, and the right-hand margin to m.  Then put another plot to its left.
# This mimics the action of oce::imagep(), with a real-world exemplification being
#
#   library(oce) # from CRAN or github
#   data(adp)    # an Acoustic-Doppler current Profile
#   plot(adp)    # should make a 4-panel plot of images and palettes


# Next 4 lines help with 'figure margins too large' error on most devices
par(mar=rep(2, 4))
omar <- par('mar')
par(mar=rep(0, 4))
frame()
par(mar=omar)
par(new=TRUE)

# Now, we mimic imagep(), which is a complicated code to read.

# The geometry as defined below may be a challenge for RStudio, but 
# similar geometries (and even those with thinner RHS plots) work
# fine in other devices.
m <- 0.5 # margin at bottom, top, and right
M <- 0.2 # space between palette and main plot
w <- 0.2 # inside width of plot

# We now calculate margins based on plot device and (m, M, w).
# Note that in imagep() I use par('pin') and not par('din')
# because I want to permit multi-panel plots. (In other words,
# what I am really doing here is sidestepping the R limitation
# on nested multi-panel plots.)
din <- par('din')
maiRHS <- c(m, din[1] - w - m, m, m)
maiLHS <- c(m, m, m, w + M + m)

## Mimic the palette
par(mai=maiRHS)
npal <- 64
col <- heat.colors(npal)
message("Draw palette, positioned with maiRHS= ", paste(round(maiRHS, 2), collapse=" "))
image(1, 1:npal, matrix(1:npal, byrow=TRUE, nrow=1), col=col,
      axes=FALSE, xlab="", ylab="")
box()
axis(4)
## Mimic main plot
par(new=TRUE, mai=maiLHS)
message("Draw main plot, positioned with maiLHS= ", paste(round(maiLHS, 2), collapse=" "))
plot(1:npal, sin(seq(0, 2*pi, length.out=npal)), pch=21, bg=col)

