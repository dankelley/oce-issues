First stab at reading/plotting VIIRS satellite data. These data have resolution
as good as 750m in parts of the image. A challenge is that the data have to be
gridded (well, I think ... maybe there are pregridded data that I've just not
found...).

* 1089a.R show SST as dots (decimated for speed)
* 1089b.R show SST image. (this led to issue 1090)
* 1089c.R steppingstone to 1089d.R
* 1089d.R working towards code that might go into oce

