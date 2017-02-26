## Try reading the "hidden" temperature channel

## Need to look at the `isMeasured` field in the `channels` table,
## which tells what data are actually stored in the `data` table.
## Note that the current version just matches the column names with
## the size of the data table, ignoring the `isMeasured` field, so it
## gets the names wrong -- for example on the test file for this
## script the hidden temperature channel gets labelled `depth` because
## that is name of the fourth column in the `channels` table
##
## Will also need to detect duplicated names (e.g. temperature) and
## append numbers to them, like temperature2, temperature3, etc.
##
## Finally, as.ctd will have to pass these extra data columns though,
## as right now it just passes the default ones

rm(list=ls())
library(oce)
options(device='x11')

if (!interactive()) png('726a-%03d.png')

d <- read.rsk('065583_20150516_1717.rsk')
plot(d)

ctd <- ctdTrim(as.ctd(d), parameters=list(pmin=10))
plot(ctd)

plotProfile(ctd, xtype='temperature')
plotProfile(ctd, xtype='temperature2', col=2, add=TRUE)
legend('bottomright', ctd[['names']][grep('temp', ctd[['names']])],
       lty=1, col=1:2)

plotProfile(ctd, xtype='temperature2')

trimTimes <- as.POSIXct(c(1431751235, 1431753589), origin='1970-01-01', tz='UTC')
ctd <- ctdTrim(as.ctd(d), 'range', parameters=list(item='time', from=trimTimes[1], to=trimTimes[2]),
               debug=10)

if (!interactive()) dev.off()
