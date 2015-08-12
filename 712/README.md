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

**DK** I created ``rsk.txtz``, a hand-edited file. The file was created as
follows. (1) ``cp 060130_20150720_1135.txt rsk.txt``.  (2) In an editor, remove
lines past the first occurrence of pressure 40dbar. (3) Hand-edit the event
sequence, trying to mimic what was there originally (changing sample numbers,
changing times, etc).  (4) ``gzip rsk.tzt`` I am not sure step 3 was done
correctly.

**DK** I created ``rsk2.txt`` which is like ``rsk.txt`` but I chopped out a lot
of equilibration data. The advantage is that the file is now small enough to
work in oce. The disadvantage is that it might give a wrong impression on how
long equilibration should last ... but this is solved by a sentence in the
manpage. NOTE: probably the events are wrong ... it's fiddly, editing (and
subtracting line numbers to get correct sample numbers) and plotting. If we use
something like this, it would be important to check the events for matchup with
sample number and time. I also don't know if all events are required, e.g. is
it necessary for a PAUSE to follow the end of sampling.

