library(oce)
if (!interactive()) png("637a_%d.png")

cm <- colormap(x0=1:2,x1=1:2,col0=c("red","blue"),col1=c("red","blue"))
str(cm)
stopifnot(2 == length(cm$x0))

## Example 1. color scheme for points on xy plot
x <- seq(0, 1, length.out=40)
y <- sin(2 * pi * x)
par(mar=c(3, 3, 1, 1))
mar <- par('mar') # prevent margin creep by drawPalette()
## First, default breaks
c <- colormap(y)
drawPalette(c$zlim, col=c$col, breaks=c$breaks)
plot(x, y, bg=c$zcol, pch=21, cex=1)
grid()
par(mar=mar)
## Second, 100 breaks, yielding a smoother palette
c <- colormap(y, breaks=100)
drawPalette(c$zlim, col=c$col, breaks=c$breaks)
plot(x, y, bg=c$zcol, pch=21, cex=1)
grid()
par(mar=mar)

## Example 2. topographic image with a standard color scheme
par(mfrow=c(1,1))
data(topoWorld)
cm <- colormap(name="gmt_globe")
imagep(topoWorld, breaks=cm$breaks, col=cm$col)

## Example 3. topographic image with modified colors,
## black for depths below 4km.
cm <- colormap(name="gmt_globe")
deep <- cm$x0 < -4000
cm$col0[deep] <- 'black'
cm$col1[deep] <- 'black'
cm <- colormap(x0=cm$x0, x1=cm$x1, col0=cm$col0, col1=cm$col1)
imagep(topoWorld, breaks=cm$breaks, col=cm$col)
mtext("EXPECT: black below 4km", side=3, line=0, font=2, col="purple")

## 20150426broken ## Example 4. image of world topography with water colorized 
## 20150426broken ##            smoothly from violet at 8km depth to blue
## 20150426broken ##            at 4km depth, then blending in 0.5km increments
## 20150426broken ##            to white at the coast, with tan for land.
## 20150426broken cm <- colormap(x0=c(-8000, -4000,   0,  100),
## 20150426broken                x1=c(-4000,     0, 100, 5000),
## 20150426broken                col0=c("violet","blue","white","tan"),
## 20150426broken                col1=c("blue","white","tan","yelloe"),
## 20150426broken                blend=c(100, 8, 0))
## 20150426broken lon <- topoWorld[['longitude']]
## 20150426broken lat <- topoWorld[['latitude']]
## 20150426broken z <- topoWorld[['z']]
## 20150426broken imagep(lon, lat, z, breaks=cm$breaks, col=cm$col)
## 20150426broken contour(lon, lat, z, levels=0, add=TRUE)
## 20150426broken mtext("EXPECT: violet to blue smooth from 8km to 4km, etc -- broken",
## 20150426broken       side=3, line=0, font=2, col="purple")

## Example 5. visualize GMT style color map
cm <- colormap(name="gmt_globe", debug=4)
plot(seq_along(cm$x0), cm$x0, pch=21, bg=cm$col0)
grid()
points(seq_along(cm$x1), cm$x1, pch=21, bg=cm$col1)

if (!interactive()) dev.off()
