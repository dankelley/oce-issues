# Files

* `testN.m` matlab code that does various test cases, and creates output files to be tested in R
* `xN.dat`, `pxxN.dat` and `wN.dat`: data produced by the commented-out code at
  start of `testN.m`
* `old/01.R`: various steps towards reproducing results of `test.m`. Apart
  from the endpoints, the spec agrees with matlab to 7 digits, after a scale
factor
* `old/02.R`: the factor has been figured out. The endpoint is OK on *one* testcase.
* `1359a.R` works on test cases with both even and odd data lengths, but *not* with extra parameters supplied to `oce::pwelch``


# Next local tasks (all within .R files herein, not in oce yet):

* allow to specify the window as a vector
* allow to specify the window as a number indicating length
* allow to specify all other things presently permitted
* consider allowing to specify other things provided by matlab


# oce tasks

* When things work well here (or a user needs it), put these new code elements
  into `oce:pwelch`
