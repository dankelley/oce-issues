# How we maintain data privacy here

The data are private. Therefore, before doing any experiments here, copy the
RDI file here as `adcp.000`, and the corresponding matlab file `adcp.mat`.
Note that the `.gitnore` file ensures that neither will get stored in the GH
repository, and it is important that you do not force them to go there. Just do
the file copying into any computer where you want to experiment.

# Notes

1. The throwing-away of the first ensemble of SentinelV files is in
   `R/adp.rdi.R` near line 710, written 2016-09-25 by CR.  I've converted an
oceDebug() call to a warning() call, so users won't be taken by surprise.

2. The loss of ensembles at the end -- fixed.

3. Pressures differ from matlab by a quantized amount (1e-3 dbar) -- cause
   unknown.

3. Testing against matlab and self:
    
    * from, to, by unspecified: ok (same as matlab on v, *nearly* on pressure)
    * alter integer-style to -- OK
    * alter integer-style by -- OK
    * alter integer-style from --
    * alter time-style to --
    * alter time-style by --
    * alter time-style from --
