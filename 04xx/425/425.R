library(oce)
data(adp)
im <- adp@data$v[,,1]
if (!interactive()) png("425.png")
imagep(im, zlim="histogram", debug=3)
mtext("EXPECT: image with nonlinear colorscale", font=2, col="purple")
if (!interactive()) dev.off()

