options(width=200)
# source: download excel file from https://doi.org/10.13155/53381, then extract
# first sheet as csv.

n <- read.csv("89960.csv", skip=1, header=TRUE)
N <- n[,c("variable.name", "CF.standard_name", "unit")]
names(N) <- c("fileName", "oceName", "unit")
head(N)
N$oceName[N$oceName=="sea_water_pressure"] <- "pressure"
head(N)
NN <- N[nchar(N$fileName)>0L,]
dim(N)
dim(NN)
NN[105,]
print(NN)
