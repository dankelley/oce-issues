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

