library(oce)
f <- "Custom.export.026043_2021-07-21_17-36-45.txt"
lines <- readLines(f, encoding="UTF-8-BOM", warn=FALSE)
lines[1]
col.names <- strsplit(lines[1], ",")[[1]]

#Comments=
#
#2021-07-21,17:36:46.17,03.107,05.867,0.21,007.80
#2021-07-21,17:36:46.21,06.010,05.986,0.25,007.80

CommentsLine <- grep("^Comments=", lines)
CommentsLine
data <- read.csv(f, skip=CommentsLine+1, header=FALSE, col.names=col.names)
# check
head(data,2)
T <- data[["Temperature..C."]]
C <- data[["Conductivity..mS.cm."]]
p <- swPressure(data[["Depth..m."]])
# check
head(data.frame(T,C,p), 2)
S <- swSCTp(conductivity=C, temperature=T, pressure=p, conductivityUnit="mS/cm", eos="unesco")
# check
head(data.frame(T,C,p,S), 2)
# If you want to use the new Gibbs equation of state, you need
# to put longitude and latitude into the object.  But these data look
# to be very fresh, so I sort of doubt that this EOS makes sense. Anyway,
# I'm inserting a North-Atlantic location, which is likely wrong for you.
ctd <- as.ctd(S, T, p, longitude=-60, latitude=40)

# Let's get an idea for what's in the file.  (My particular interest
# is whether the S makes sense.)
summary(ctd)
if (!interactive()) png("01dk.png")
plot(ctd)
if (!interactive()) dev.off()

