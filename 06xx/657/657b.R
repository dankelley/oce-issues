library(oce)
data(section)
top <- sectionGrid(section, p=seq(0, 200, 5))
bottom<- sectionGrid(section, p=seq(200, 6000, 100))
if (!interactive()) png("657b.png")
layout(matrix(1:2, nrow=2), widths=1, heights=c(0.25, 0.75))
plot(top, which="temperature", mar=c(0, 3, 1, 1), axes=FALSE, legend.loc="")
axis(2, at=pretty(par('usr')[3:4]))
plot(bottom, which="temperature", mar=c(3, 3, 0.4, 1))
if (!interactive()) dev.off()

