1. The problem was in gsw-c, so I reported an error there
https://github.com/TEOS-10/GSW-C/issues/17

2. 1274b.R shows that one of the stations has dynheight of -1.4e82 but that's a
   case with just 3 levels, below 4000m depth. I don't know why that comes out
with such a weird value but I don't care that much, really, since it ought to
be trimmed.

3. 1274c.R trims the very weird one.
