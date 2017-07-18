I'm trying to determine why the gsw method gives NaN, which becomes NA in R, on
the 51st station in data(section). It fails in other cases, also.  I suspect
it's a problem of interpolation between levels. In the unesco code, I do
something very simple in oce (linear between levels) but gsw does something
more complicated in terms of interpolation.

Of course, the problem could be in the C code. I think it's been worked and
reworked, and has had malloc() problems in the past.

I'll try to figure this out before contacting teos-10, so I can offer a
solution and not just a complaint.


