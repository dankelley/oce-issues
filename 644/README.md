This directory will contain code, plus (PUBLIC DOMAIN) data files. The latter
should include .cnv and .rsk file, for this to be of much help in improving
oce.

INSTRUCTIONS. when a data file is added, a note should be put below on its
source. Also, the .R file must be updated with the file name and the expected
unit, so that "make" will produce an error if incorrect results are found.  It
makes sense to use ``head`` or an editor to trim large data files -- we just
need sufficient data lines to permit checking values of inferred salinity and
so forth; a few dozen lines should be fine.

**01.cnv** the ctd.cnv file provided with the oce package. Ownership: DK.

**02.cnv** first 1000 lines of file d2013-04-0001.cnv from the Beaufort Gyre
Exploration Program, downloaded in a zip file from
http://www.whoi.edu/beaufortgyre/data/LSSL_ctd2013.zip on 9 May 2015.
