#!/usr/bin/python
from __future__ import print_function
import re, sys
decimate = 20
lines = sys.stdin.readlines()
nlines = len(lines)
idata = 0
ithumbnaildata = 0
for i in range(nlines):
    if re.search('^INSERT INTO "data"', lines[i]):
        idata = idata + 1
        if not idata%decimate:
            print(lines[i], end="")
    elif re.search('^INSERT INTO "thumbnailData"', lines[i]):
        ithumbnaildata = ithumbnaildata + 1
        if not ithumbnaildata%decimate:
            print(lines[i], end="")
    elif re.search('^INSERT INTO "downloads"', lines[i]):
        print(re.sub("X'.*'", "NULL", lines[i]), end="")
    else:
        print(lines[i], end="")


