545.R original code.

545B.R colourize countries/islands, and test the idea that Antarctica is
causing the problem. The option "issue545B" does a temporary hack: simply
deleting Antarctica.  As the graph illustrates, this solves the problem.
Possibly this only comes up with proj4 because it mapproj is limited in terms
of other-pole latitude.  (I do not understand what mapproj is doing with
stereographic, actually.)

