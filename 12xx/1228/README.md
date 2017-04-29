# How we maintain data privacy here

The data are private. Therefore, before doing any experiments here, copy the
RDI file here as `adcp.000`, and the corresponding matlab file `adcp.mat`.
Note that the `.gitnore` file ensures that neither will get stored in the GH
repository, and it is important that you do not force them to go there. Just do
the file copying into any computer where you want to experiment.

# Notes

1. the throwing-away of the first ensemble is in `R/adp.rdi.R` line 710,
   written 2016-09-25 by CR.  But I'm more interested in the near-end NA
problem, so I'm not going to risk perturbing the code by addressing this issue
(for now).

2. the near-end NA problem starts at ensemble ensemble 8281 at 2016-06-29
   04:00:36.93; before then, oce and matlab velocities (at least component 1)
match. After that, oce is NA.

3. oce gets coords as SFM; CR says this is right, and that matlab names
   variables as if enu.

4. the problem is that the buffer is growing. If I index into it, all seems ok.
   But I want to find out how the buffer is changing.

WARNING cindex=742 iobuf=0
WARNING cindex=1483 iobuf=745    3
WARNING cindex=2224 iobuf=1490   7
WARNING cindex=2965 iobuf=2235  11
WARNING cindex=3706 iobuf=2980  15
WARNING cindex=4447 iobuf=3725  19
WARNING cindex=5188 iobuf=4470  23
WARNING cindex=5929 iobuf=5215  27
WARNING cindex=6670 iobuf=5960  31
WARNING cindex=7411 iobuf=6705  35

5. Also, the buffer differs, e.g. below (bytes 82 and 87). How can two bytes
   change like that?

     i buf2 BUF
1   70   09  09
2   71   01  01
3   72   00  00
4   73   ff  ff
5   74   00  00
6   75   98  98
7   76   09  09
8   77   00  00
9   78   00  00
10  79   14  14
11  80   80  80
12  81   00  00
13  82   02  01 *
14  83   00  00
15  84   0e  0e
16  85   08  08
17  86   09  09
18  87   04  02 *
19  88   00  00
20  89   03  03
21  90   00  00
22  91   00  00
23  92   00  00
24  93   00  00
25  94   f9  f9
26  95   05  05
27  96   00  00
28  97   00  00
29  98   00  00
30  99   00  00
31 100   1e  1e


# Files and results of running them

* 1228a.R verifies that oce is missing the first ensemble. *However* it also
  shows a deviation between matlab pressures and oce pressures. Look at the end
of the output. The right-most column of that is the difference between oce and
matlab pressure (with index offset by 1), minus a constant value of 0.128 (that
I got by trial and error). For reasons I don't know, this difference is always
a small integer times 1e-3.  I assume that's some sort of rounding artifact.

* 1228b.R looks at velocity (just 1 component). Result: diff at start (matlab
  is inserting 2^15 values, like missing values I guess) and from ensemble
number 8281 (found using locator() on the graph ... I've not looked at the data
carefully yet)


