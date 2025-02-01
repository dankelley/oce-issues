# https://www.ncei.noaa.gov/archive/archive-management-system/OAS/bin/prd/jquery/accession/download/7301162
f <- "44687"
# next is a helper for checking what we are reading
S <- function(x) cat(deparse(substitute(expr = x, env = environment())), ": '", x, "'\n", sep="")
lines <- readLines(f)
# testing with just first line in file
l <- lines[1]
S(l)
WMOquadrant <- substr(l, 3, 3)
S(WMOquadrant)
if (!WMOquadrant %in% c(1, 3, 5, 7)) {
    stop("area=", WMOquadrant, " is not in permitted list 1, 3, 5 or 7")
}
latitudeDDMMX <- substr(l, 4, 8)
S(latitudeDDMMX)
latitudeHemisphere <- substr(l, 9, 9)
S(latitudeHemisphere)
if (!latitudeHemisphere %in% c("S", "N")) {
    stop("latitudeHemisphere=", latitudeHemisphere, " must be 'S' or 'N'")
}
latitudePrecision <- substr(l, 10, 10)
S(latitudePrecision)

longitudeDDMMX <- substr(l, 11, 16)
S(longitudeDDMMX)
longitudeHemisphere <- substr(l, 17, 17)
S(longitudeHemisphere)
if (!longitudeHemisphere %in% c("E", "W")) {
    stop("longitudeHemisphere=", longitudeHemisphere, " must be 'S' or 'N'")
}
longitudePrecision <- substr(l, 18, 18)
S(longitudePrecision)
YYMMDD <- substr(l, 19, 24)
S(YYMMDD)
HHMM <- substr(l, 25, 28)
S(HHMM)
blank1 <- substr(l, 30, 30)
S(blank1)
country <- substr(l, 31, 32)
S(country)
blank2 <- substr(l, 33, 33)
S(blank2)
S(l)
# Skip a lot of things, since the above seem (maybe) OK and I want to get to
# the "good stuff"
bottomDepth <- substr(l, 82, 85)
S(bottomDepth) # why blank? maybe I don't worry, though
# OK, let's skip to see if we can find T=T(z) data, AKA the "good stuff".
count <- as.integer(substr(l, 96, 99))
S(count)
if (count <= 0) {
    stop("count=", count, " is not possible")
}
depth <- rep(NA, count)
temperature <- rep(NA, count)
offset <- 101 # character offset
for (i in seq_len(count)) {
    depth[i] <- as.numeric(substr(l, offset, offset + 3)) # metres
    temperature[i] <- 0.01 * as.numeric(substr(l, offset + 4, offset + 7)) # factor yields degC
    offset <- offset + 8
}
print(data.frame(depth = depth, temperature = temperature))
if (!interactive()) {
    png("2289b.png")
}
plot(temperature, depth, ylim = rev(range(depth)), type = "o", pch = 20)
if (!interactive()) {
    dev.off()
}
