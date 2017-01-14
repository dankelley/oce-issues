PURPOSE. Test suite for oce ctd-reading improvements, e.g. (a) recognizing
conductivity units, (b) recognizing temperature units (see [blog
item](http://dankelley.github.io/r/2015/05/10/ITS90-temperature-scale.html)),
...

INSTRUCTIONS. 

1. Data files must be in the public domain.

2. When a data file is added, a note should be put below on its source. It may
   be sensible to number data files, and to insert initials in their names, to
avoid collisions.

3. The .R file must be updated with the file name and the expected unit, so
   that "make" will produce an error if incorrect results are found.

4. It probably makes sense to use ``head`` or an editor to trim large data
   files -- we just need sufficient data lines to permit checking values of
inferred salinity and so forth; a few dozen lines should be fine.

FILES.

* **01dk.cnv** the ctd.cnv file provided with the oce package. Ownership: DK.

* **02dk.cnv** first 1000 lines of file d2013-04-0001.cnv from the Beaufort Gyre
Exploration Program, downloaded in a zip file from
http://www.whoi.edu/beaufortgyre/data/LSSL_ctd2013.zip on 9 May 2015.

* **03dk.cnv** first 200 lines of file ``2008-07-03_st071.cnv`` from SLEIWEX
  (DK and CR and colleagues own; no stable URL for download)
  **NOTE** this causes an error, issue 645.

* **04dk.cnv** file ``Station_A_2010_01.cnv`` from in Isaeli dataset (DK can't
  remember the URL but it seems probable that it was
http://www.meteo-tech.co.il/eilat-yam/eilat_instructions_en.asp, a dataset that
was down when he checked it on 9 May 2015). Another URL that seems like it
should supply these data is
http://www.meteo-tech.co.il/EilatYam_data/ey_ctd_data_download.asp but that was
disfunctional as of 9 May 2015. In any case, the present paragraph is a
hear-say indication that the data are publically available.
