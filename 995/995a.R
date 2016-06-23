library(oce)

if (!interactive()) png("995a.png")

data(section)
plot(section, which='temperature', ztype='image',
     adorn=expression({
         abline(v=500, col='yellow', lwd=3)
         mtext("500km", at=500, side=1)
     })
     )
abline(v=1000, col='red', lwd=3)

if (!interactive()) dev.off()

