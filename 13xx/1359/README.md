# Files

* `test.m`
* other `*.m` the .m files required to run the pwelch example in `test.m`
* `x.dat` data produced by the commented-out code at start of `test.m`
* `pxx.dat` data produced by running `test.m` (i.e. the welch spectral output)
* `01.R` etc, various steps towards reproducing results of `test.m`. Apart from
  the endpoints, the spec agrees with matlab to 7 digits, after a scale factor
* `02.R` factor figured out. endpoint ok on *one* testcase. FIXME: even/odd length
* `1359a.R` uses the above; tests for both even and odd data lengths


# Next tasks:

* allow to specify window as vector
* allow to specify window as number indicating length
* allow to specify all other things presently permitted
* consider allowing to specify other things provided by matlab

