# Diary

## Detect end-of-file 

This solves the error we saw before.

## bottomTrack 'version 3' error

We get error

```
Error in read.adp.ad2cp(f1, debug = 3) : 
  can only decode 'bottomTrack' data records that are in 'version 3' format
```

This is coming from the test
```R
if (any(version[p$bottomTrack] != 3))
```
failing.

So, I exported some things into `DAN`, and see as follows.  I need to read up
some more on the version setup


```
> str(DAN)
List of 2
 $ p      :List of 11
  ..$ burst           : int [1:648] 2 13 24 35 46 57 69 80 91 102 ...
  ..$ average         : int [1:360] 3 5 7 9 11 14 16 18 20 22 ...
  ..$ bottomTrack     : int [1:360] 4 6 8 10 12 15 17 19 21 23 ...
  ..$ interleavedBurst: int(0)
  ..$ burstAltimeter  : int [1:108] 1 68 135 142 149 156 163 170 177 184 ...
  ..$ DVLBottomTrack  : int(0)
  ..$ echosounder     : int(0)
  ..$ DVLWaterTrack   : int(0)
  ..$ altimeter       : int(0)
  ..$ averageAltimeter: int(0)
  ..$ text            : int(0)
 $ version: int [1:1476] 3 3 3 1 3 1 3 1 3 1 ...
> table(DAN$version)

   1    3
 360 1116
```

And now, for the actual test:

```R
> DAN$version[DAN$p$bottomTrack]
  [1] 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
 [49] 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
 [97] 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
[145] 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
[193] 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
[241] 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
[289] 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
[337] 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
```

**NEXT:** I need to read the docs to find out how version 1 differs from version 3.

## create smaller test file for inclusion in oce

1954b.R: chunks start at cindex= 0 4677 6274 7871 9468 11065 12662 
TO get first 3, use
```
#split -b 7871 -n 1 S102791A002_Barrow_v2.ad2cp
split -b 7870 tmp.ad2cp
od -x tmp.ad2cp | head -2
od -x xaa | head -2
```





# 2022-06-26

I changed `1954a.R` to save `d` in `1954a.rda`, and then copied this manually
to `1954a_unvectorized.rda`, while also copying `1954a.out` to
`1954a_unvectorized.txt`. This is to give a base state for checking
vectorization.

