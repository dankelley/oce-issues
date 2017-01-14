library(oce)
f <- "/data/flemishCap/moorings/1840/Processed_RCMnew/MCM_HUD2013021_1840_0685_3600.ODF"
if (1 == length(list.files(path='/data/flemishCap/moorings/1840/Processed_RCMnew',
                           pattern="MCM_HUD2013021_1840_0685_3600.ODF"))) {
    d <- read.odf(f)
    cm <- as.cm(d)

    summary(d)
    summary(cm)

    if (!interactive()) png("1023a.png")
    par(mar=c(3, 3, 3, 1), mgp=c(2, 0.7, 0))
    ddir <- 90 - d[['directionTrue']]
    du <- d[['speedHorizontal']] * cos(ddir * pi / 180)
    dv <- d[['speedHorizontal']] * sin(ddir * pi / 180)
    plot(du, dv, asp=1)
    grid()
    points(cm[['u']], cm[['v']], pch='+', col='red')
    if (!interactive()) dev.off()
} else {
    warning("no data file")
}

