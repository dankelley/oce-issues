# Messages

* DK to CR 20151122: I'm not sure how to know which files are readable, so I
  made a test that just looks for 000 at the end of the filename ... and that
fails in at least one class (the winriver_vesselmounted_1200kHz data) so I'm
not sure about how to write an R script that tests relevant files and skips
other.  My hope is that people can use read.oce() instead of having to use
read.adp.rdi(), hence my tests of whether oceMagic() infers adp/rdi as the data
type.

