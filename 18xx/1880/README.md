How to work here

1. Remove oce and reinstall from CRAN.
2. Edit 1880a.R, setting build<-TRUE in the first line.
3. Uninstall the local oce, and install the CRAN version instead.
3. Type 'make' to create the 1880a_cran.rda file. (Note of the execution time.)
4. Add this rda file to the repo.
5. Edit 1880a.R again, changing the first line to build<-FALSE
6. Rebuild a local copy of oce.
7. Run 'make' again.  This should run without errors, unless the local oce is
   creating different results from the CRAN oce.


# Performance/coding notes

## Should we use C++ array-based methods more?

Instead of looping in the C manner,
```
for (int i = 0; i < nxg; i++)
   for (int j = 0; j < nyg; j++)
     zg(i, j) = zz(i, j);
```
we can use
```
zg = clone(zz);
```
which should be clearer to readers.  I ran multiple timing tests as
I experimented, monitoring the t.test output until the 95%CI was under 0.1s.  

* using C   style assignments: 5.358 ± 0.097 s
* using C++ style assignments: 3.993 ± 0.051 s

So, the C++ style seems to be 25% faster (perhaps because it avoids the
overhead of overloading the `[` and `)` operators) and also more elegant.
I will switch the code.



