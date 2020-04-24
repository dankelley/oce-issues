library(oce)
files <- c("CTD_HUD2013037_042_1_DN.ODF", "CTD_HUD2015030_127_1_DN.ODF")
for (file in files) {
    message(file)
    print(system.time({d <- read.oce(files[1])}))
    summary(d)
}


