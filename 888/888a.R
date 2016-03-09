library(oce)
source("~/src/oce/R/adv.nortek.R")
source("~/src/oce/R/oce.R")
# only works for Kelley and Richards
if (1 == length(list.files(path="/data/archive/sleiwex/2008/moorings/m05/adv/nortek_1943/raw",
                           pattern="adv_nortek_1943.vec"))) {
    d <- read.oce("/data/archive/sleiwex/2008/moorings/m05/adv/nortek_1943/raw/adv_nortek_1943.vec")
} else {
    message("you need certain private data files to run this test")
}
