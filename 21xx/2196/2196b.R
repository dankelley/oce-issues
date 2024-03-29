# This has to be run *after* running 2196a.R (the easy way is to use the
# Makefile).  The goal is to make some plots so the owner of the data
# can help me to see if things are on the right track. The data are
# PRIVATE, so the output from this script are not to be put on github,
# but rather are sent to the owner by email.

library(oce)
load("d.rda") # creates 'd', an ADP object produced by 2196a.R
if (interactive()) {
    x11()
} else {
    png("2196b_%02d.png", unit = "in", width = 7, height = 7, pointsize = 9, res = 150)
}

# Let's start by examining the pressure record.  If this is wildly noisy or has
# unexpected values, then the data might be bad.
plot(d, which = "pressure")

# OK, this looks like data to me.  We could trim the deployment/recover in
# different ways, but a crude and simple way is by subsetting to a pressure
# range. Note that I am replacing 'd' here, to avoid running out of memory by
# having a lot of large objects lingering after they have served their purpose.
d <- subset(d, pressure > 95)
plot(d, which = "pressure")

# Pressure looks good.  Let's have a look at beam 1 velocity
plot(d, which = 1)

# I'm not too sure what is going on at distances exceeding about 95m,
# which I see only for the first two months and the the last two months.
# Perhaps the data owner can look at this. In any case, I'll now replot
# that but choosing my own scale, to see if it looks like signal
# in those near-white zones.
plot(d, which = 1, zlim = c(-0.2, 0.2))

# Well, I'm still not sure what's going on.  It does not
# look like bit noise, though.  Let's try looking at
# just the first day.
t0 <- d[["time"]][1]
plot(subset(d, time < t0 + 86400), which = 1, zlim = c(-0.2, 0.2))

# Something is odd here.  The signal is very blocky, but the width
# of those blocks (the time interval) is too large to give
# a file this big. Let's zoom in on the first hour.
plot(subset(d, time < t0 + 3600), which = 1, zlim = c(-0.2, 0.2))

# Oh, I see!  This is bursting.  The blockiness was sampling between
# bursts.  At this stage, I think the data owner likely can 
# assess whether oce is reading data at least semi-properly,
# so I could stop here, but I want to see what it is like in ENU
# coordinates.
plot(toEnu(subset(d, time < t0 + 3600)), which = 1, zlim = c(-0.2, 0.2))

# So, generally westward during this first hour. Here's what
# it is in this first hour, averaging across the data. (This
# makes no physical sense because it combines bursts
# and non-bursts, but still it lets us see something). So,
# this is another question for the data owner: does
# this profile make any sense?
plot(toEnu(subset(d, time < t0 + 3600)), which = 24, zlim = c(-0.2, 0.2))

# I'll end by getting a summary of this first hour of data.
# Again, the hope is that the data owner can get back to
# me with some indication as to whether things seem reasonable.
# For example, is the cell size right? How about the beam
# angle, etc etc?
summary(toEnu(subset(d, time < t0 + 3600)))

