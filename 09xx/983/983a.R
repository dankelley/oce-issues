library(oce)
data(section)
names <- names(section[['station',1]]@data)
if (!interactive()) png("983a.png")
par(mfrow=c(3,3), mar=c(3, 3, 1, 1), mgp=c(2, 0.7, 0))
for (name in names) {
    hist(section[[name]], main="", xlab=name) # a check on issue 983
}
if (!interactive()) dev.off()
