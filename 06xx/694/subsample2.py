#!/usr/bin/python
from __future__ import print_function
import re, sys
lines = sys.stdin.readlines()
nlines = len(lines)
idata = 0
ithumbnaildata = 0
## Chop to times in range 14362092860000:14362093180000, selected by
## locator() in R, to find the downcast.
tstart = 1436209286000
tend =   1436209318000
for i in range(nlines):
    if re.search('^INSERT INTO "data"', lines[i]):
        tstamp = int(re.sub(",.*","",re.sub(".*\(", "", lines[i])))
        # print("--", lines[i])
        # print("--", tstart, " ", tstamp, " ", tend, end=" ")
        # print("--", tstart<=tstamp, end=" ")
        # print("--", tstamp<=tend, end=" ")
        # print("--", tstart<=tstamp and tstamp<=tend)
        if tstart <= tstamp and tstamp <= tend:
            print(lines[i], end="")
    elif re.search('^INSERT INTO "thumbnailData"', lines[i]):
        tstamp = int(re.sub(",.*","",re.sub(".*\(", "", lines[i])))
        if tstart <= tstamp and tstamp <= tend:
            print(lines[i], end="")
    elif re.search('^INSERT INTO "downloads"', lines[i]):
        print(re.sub("X'.*'", "NULL", lines[i]), end="")
    else:
        print(lines[i], end="")


