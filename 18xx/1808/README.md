---
title: coding notes
author: Dan Kelley
date: 2021 Apr 29 and later times
---


# Test files

* 1808a.R Tests two local ODF CTD files, one from BIO and one from IML.
* 1808b.R Tests multiple local ODF files, mainly from the "odf_transform"
  branch of the cioos-siooc repository
https://github.com/cioos-siooc/cioos-siooc_data_transform.git.

# Problems

* `/Users/kelley/git/oce-issues/18xx/1808/CTD_AMU2019001_001_01_DN.ODF` (file 6
  of 1808b.R) The QC flags do not have codes matching the QQQQ pattern of
previously-handled files, but rather they are named as "Q" followed by the code
string of the just-previous item.  Similar for files 8:12, and perhaps others.

