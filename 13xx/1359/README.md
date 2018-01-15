# Files

* `test.m`
* other `*.m` the .m files required to run the pwelch example in `test.m`
* `x.dat` data produced by the commented-out code at start of `test.m`
* `pxx.dat` data produced by running `test.m` (i.e. the welch spectral output)
* `01.R` etc, various steps towards reproducing results of `test.m`. Apart from
  the endpoints, the spec agrees with matlab to 7 digits, after a scale factor
* `02.R` factor figured out. endpoint ok on *one* testcase. FIXME: even/odd length
* `03.R` PLAN: another example of different length (preferably short for
  inclusion in test suite)
* '04.R' PLAN: other args, e.g. specify nwindow, specify window type, etc (a
  LOT of work remains and I want it all to be exactly right)

