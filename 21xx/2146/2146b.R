# are there enough digits in the harmonic amplitude and phase?
d <- read.delim("harmonics.tsv", sep="\t")
d$freq <- d$Speed / 360
d$period <- 1/d$freq
o <- order(d$period)
d <- d[o,]
look <- 18 < d$period & d$period < 30
options(digits=15)
print(head(d[look, c("Name", "Amplitude", "Phase", "period")], 20))
