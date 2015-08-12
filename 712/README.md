# Reading Ruskin-exported txt files using oce

Typically these will be files that were originally recorded as `hex` files, e.g. on an RBR XR-620 CTD. The first line in such files is typically:

    Model=XR-620

or

    Model=RBRconcerto

so `oceMagic()` can be modified to recognize the file with something like:

    if ("Model=" == substr(line, 1, 6))  {
        oceDebug(debug, "this is rsk\n")
        return("rsk")


## Test data

* `pt_rbr_014765.dat`: A truncated version of the original sleiwex pt data file

* `060130_20150720_1135.txt`: a txt export from Ruskin of a recent RSK file


## Possible rsk dataset

**DK** I created ``rsk.txt.gz``, a gzipped version of a hand-edited file. The
file was created as follows. (1) ``cp 060130_20150720_1135.txt rsk.txt``.  (2)
In an editor, remove lines past the first occurrence of pressure 40dbar. (3)
Hand-edit the event sequence, trying to mimic what was there originally
(changing sample numbers, changing times, etc).  (4) ``gzip rsk.tzt`` I am not
sure step 3 was done correctly.

