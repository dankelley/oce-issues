# How we maintain data privacy here

The data are private. Therefore, before doing any experiments here, copy the
RDI file here as `adcp.000`, and the corresponding matlab file `adcp.mat`.
Note that the `.gitnore` file ensures that neither will get stored in the GH
repository, and it is important that you do not force them to go there. Just do
the file copying into any computer where you want to experiment.

# Diary of experiments

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


