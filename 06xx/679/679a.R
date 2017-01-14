library(oce)
if (!interactive()) png("679a_%02d.png")
for (file in list.files(".", pattern="*.rsk$")) {
    message("plotting ", file)
    plot(read.oce(file))
}
data(rsk)
plot(rsk)
plot(rsk, which=c(1,3,4)) # the old default
if (!interactive()) dev.off()
