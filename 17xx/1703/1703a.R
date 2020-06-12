## Demonstrate that things are OK for single-profile files.
library(oce)
file <- system.file("extdata", "D4900785_048.nc", package="argoFloats")
a <- read.argo(file)
A <- a[["HISTORY_QCTEST"]]
library(ncdf4)
n <- nc_open(file)
# sink('1.txt');n;sink()
##         char HISTORY_QCTEST[STRING16,N_PROF,N_HISTORY]
##             long_name: Documentation of tests performed, tests failed (in hex form)
##             conventions: Write tests performed when ACTION=QCP$; tests failed when ACTION=QCF$
##             _FillValue:
B <- ncvar_get(n, "HISTORY_QCTEST")
## Next shows same apart from trimmed trailing whitespace
stopifnot(all.equal(A, gsub("[ ]*$", "", B)))

