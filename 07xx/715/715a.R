library(testthat)
library(oce)
path <- "/data/Barrow Strait Data/2003_2004/MooredCTD"
file <- "MCTD_PRD2003001_1491_0770_1800.ODF"
if (1 == length(list.files(path=path, pattern=file))) {
    d <- read.oce("/data/Barrow Strait Data/2003_2004/MooredCTD/MCTD_PRD2003001_1491_0770_1800.ODF")
    expect_equal(d@metadata$deploymentType, "moored")
    dd <- read.odf("/data/Barrow Strait Data/2003_2004/MooredCTD/MCTD_PRD2003001_1491_0770_1800.ODF")
    expect_equal(dd@metadata$deploymentType, "moored")
} else {
    message("715a.R only works if a local file is available")
}

