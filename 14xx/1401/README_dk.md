## DK notes

All use the "dk" branch, which has extra debugging (all of which may disappear
at any time).


### with debug=101

This makes a 5Mb .out file, with lines like

```
unknown buf[833,]=0x01 and buf[834]=0x21
unknown buf[932,]=0x02 and buf[933]=0x21
unknown buf[979,]=0x03 and buf[980]=0x21
unknown buf[1071,]=0x00 and buf[1072]=0x37
unknown buf[1123,]=0x01 and buf[1124]=0x0c
unknown buf[1188,]=0x32 and buf[1189]=0x00
unknown buf[1430,]=0x70 and buf[1431]=0x70
unknown buf[1552,]=0x71 and buf[1553]=0x79
unknown buf[1674,]=0x64 and buf[1675]=0x64
unknown buf[1796,]=0xdc and buf[1797]=0x1e
unknown buf[1877,]=0x12 and buf[1878]=0x04
```

A diff on the first index of buf gives
```
[1]  99  47  92  52  65 242 122 122 122  81  99
```
which is odd (not same length). Also, note that 
```
> ldc0$ensembleStart[1:3]
[1]    1 1045 1875
```
so the first 3 of these unrecognized codes are within the first profile.

**Q:** is it looking for codes in the right places?  With this instrumentation,
we get *no* unrecognized codes in the file used to create `data(adp)`, and that
fact may help in tracing the logic flow to try to find an error in code
seeking.

