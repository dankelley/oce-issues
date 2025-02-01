f <- "44687"
lines <- readLines(f)
# testing
l <- lines[1]
l
WMOquadrant <- substr(l, 3, 3)
if (!WMOquadrant %in% c(1, 3, 5, 7)) {
    stop("area=", WMOquadrant, " is not in permitted list 1, 3, 5 or 7")
}
latitudeDDMMX <- substr(l, 4, 8)
latitudeDDMMX
latitudeHemisphere <- substr(l, 9, 9)
latitudeHemisphere
if (!latitudeHemisphere %in% c("S", "N")) {
    stop("latitudeHemisphere=", latitudeHemisphere, " must be 'S' or 'N'")
}
latitudePrecision <- substr(l, 10, 10)
latitudePrecision

longitudeDDMMX <- substr(l, 11, 16)
longitudeDDMMX
longitudeHemisphere <- substr(l, 17, 17)
longitudeHemisphere
if (!longitudeHemisphere %in% c("E", "W")) {
    stop("longitudeHemisphere=", longitudeHemisphere, " must be 'S' or 'N'")
}
longitudePrecision <- substr(l, 18, 18)
longitudePrecision
date <- substr(l, 19, 24)
date
time <- substr(l, 25, 28)
time
# Skip a lot of things, since the above seem (maybe) OK and I want to get to
# the "good stuff"
bottomDepth <- substr(l, 82, 85)
bottomDepth # why blank? maybe I don't worry, though
# OK, maybe there are data ...

count <- as.integer(substr(l, 96, 99))
count
if (count <= 0) {
    stop("count=", count, " is not possible")
}
depths <- rep(NA, count)
temperatures <- rep(NA, count)
offset <- 101

for (i in seq_len(count)) {
    depths[i] <- as.numeric(substr(l, offset, offset + 3)) # metres
    temperatures[i] <- 0.01 * as.numeric(substr(l, offset + 4, offset + 7)) # factor yields degC
    offset <- offset + 8
}
print(data.frame(depth=depths, temperature=temperatures))
png("2289a.png")
plot(temperatures, depths, ylim=rev(range(depths)), type = "o", pch=20)
