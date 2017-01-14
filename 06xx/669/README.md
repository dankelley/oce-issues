Now, if lon and lat are each just single values, they go in metadata.
Otherwise, they go in data. I don't think we really have sufficient tests in
this directory, and they address other issues, but maybe CR can check and
either put in some better tests showing it works, nor put in tests showing it
fails.  By "work" and "fail", I think I mean with respect to things we might do
with the data, like plotting, summarizing, etc.

