library(oce)
options(warn=1)
f <- '~/Dropbox/oce-working-notes/tests/adp-rdi/winriver_vesselmounted_1200kHz/DATA_20080701123035_000r.000'
if (file.exists(f)) {
    d <- read.adp.rdi(f, debug=100) # debug > 10 yields LDC for examination
}

## I don't see a pattern to the timing, but the fact that
## there are only 3 chunk lengths suggests this is not an error.
print(table(diff(ldc0$ensembleStart)))
plot(head(diff(ldc0$ensembleStart), 200), type='s', col='lightgray')
points(head(diff(ldc0$ensembleStart), 200), pch=20, cex=0.7, col=2)
