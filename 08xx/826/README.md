This issue relates to a problem with using `imagep()` with RStudio.  In many
cases, this yields an error message about figure margins, instead of producing
the graph within the plotting panel of RStudio. I am trying to learn why that
happens so I can fix the bug. My assumption is that it has to do with the graph
metrics, as revealed by the output from `par()`.

The file `test.R` is designed to test for the error, in the simplest possible
code. It tries to make a plot, and it spits out a lot of diagnostic
information.

I know for sure that this test will work on some machines and not others. I'm
hoping users can supply some of the output from `test.R` to me, so I can get
closer to a solution to the bug.

So, dear user ... if you have time, I ask that you run the code `test.R` in
RStudio and in normal R, and cut/paste the textual results into filenames with
your initials, and email me those files, along with a word or two stating
whether you saw the graphs as desired, or saw an error message about figure
margins. Please name the files `test_INITIAL_SOFTWARE.txt`, e.g. my test with
normal R gave `test_dk_r.txt` in the present directory, and my test with
RStudio gave `test_dk_rstudio.txt` here.

I will put the files here, and update the summary table `test_results.txt` to
indicate success or failure.

Given some luck, I'll see the problem and fix it quickly.

NOTE: I think the problem may be restricted to OSX machines (and possibly just
those with small-pixel displays), but I'd love to get some results from Windows
also, because we have many Windows users of oce.

