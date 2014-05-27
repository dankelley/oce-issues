# Resources

* [odv format](https://www.bodc.ac.uk/data/codes_and_formats/odv_format/)

* Sample file: download the [an xls file](http://www.seadatanet.org/content/download/9752/65735/file/Examples%20of%20SeaDataNet%20variant%20ODV%20spreadsheet-based%20import%20format.xls)
open in excel, and copy/paste the relevant CTD sheet to a local file named
``profile.odv``.

# 456a.R

Simple file to test ideas.

# 456b.R

Start making the code be more like ``read.ctd.sbe()`` for example.  (That is, get the arg list right.)

# 456c.R

Extends 456b.R with more general code.  Note that the ODF format is not as
fixed as some documentation led me to believe, e.g. the BIO data in data/ have
different names for temperature than the profile.odv file.

# 456d.R

As 456c.R but with BIO data.
