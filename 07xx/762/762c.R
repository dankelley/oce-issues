## Implement from= and to= args.

## For first pass they will have to be POSIX times (to be converted to RSK time, i.e. milliseconds since unix epoch), but probably the way to deal with integers (i.e. indices) is to read the entire times vector and then match the index given to the nearest time

rm(list=ls())
library(oce)

if (!interactive()) png('726c-%03d.png')
par(oma=c(0, 0, 2, 0))

d <- read.rsk('065583_20150516_1717.rsk')
plot(d)
title('')
title('from/to not provided', outer=TRUE)

from <- as.POSIXct("2015-05-16 04:41:23", tz="UTC")
d <- read.rsk('065583_20150516_1717.rsk', from=from)
plot(d)
title('')
title('from only provided', outer=TRUE)

from <- as.POSIXct("2015-05-16 04:41:23", tz="UTC")
to <- as.POSIXct("2015-05-16 05:19:37", tz="UTC")
d <- read.rsk('065583_20150516_1717.rsk', from=from, to=to)
plot(d)
title('')
title('from/to as POSIXct', outer=TRUE)

from <- "2015-05-16 04:41:23"
to <- "2015-05-16 05:19:37"
d <- read.rsk('065583_20150516_1717.rsk', from=from, to=to)
plot(d)
title('')
title('from/to as character', outer=TRUE)

from <- 25000
to <- 75000
d <- read.rsk('065583_20150516_1717.rsk', from=from, to=to)
plot(d)
title('')
title('from/to as indices', outer=TRUE)

if (!interactive()) dev.off()
