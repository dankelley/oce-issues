# Goal

See whether NOAA's sealevel predictions can be recovered by feeding reported
harmonics to as.tidem() and then predict().

# Files and results

## 2142a.R

Test oce sealevel predictions (using as.tidem() and then predict()) against
NOAA predictions.  I am not sure why the deviation (bottom panel of the plot)
has a systematic low-frequency pattern.

## 2142b.R

As 2142a.R but with a different tRef. The results still have the general
character, but the RMS deviation is much larger.  This tells me that the choice
of tRef matters for detailed work.  Unfortunately, I don't know how to find out
what tRef NOAA had used, for any given set of harmonics.  If I had to guess,
perhaps I'm guess that it was the previous full year, or something like that.
