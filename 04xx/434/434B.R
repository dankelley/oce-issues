if (!interactive()) png("434B.png", width=7, height=7, unit="in", res=150, pointsize=12)

library(oce)
cm <- colormap(name="gmt_globe")

par(mfrow=c(2,1))
par(mar=c(3,3,1,1))
plot(seq_along(cm$x0), cm$x0, pch=21, bg=cm$col0, type='p')
grid()
points(seq_along(cm$x0), cm$x0, pch=21, bg=cm$col0)
points(seq_along(cm$x1), cm$x1, pch=21, bg=cm$col1)

plot(seq_along(cm$x0), cm$x0, cex=2, pch=21, bg=cm$col0, type='p', xlim=c(20, 23), ylim=c(-600, 300))
grid()
points(seq_along(cm$x0), cm$x0, cex=2, pch=21, bg=cm$col0, type='p')
points(seq_along(cm$x1), cm$x1, cex=2, pch=21, bg=cm$col1)

if (!interactive()) dev.off()
