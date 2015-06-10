The files here won't mean much except to the author or others who are familiar
with C.

* *.R before 06: some have a nice tracing method with code that will possibly
  be useful ater on.

* 06.R simple polygon chopper, made-up island with moving cut point

* 07.R / polygon3.c -- simple polygon chopper with coastlineWorld. Bugs:
    - A few cases have UHL, e.g. for lon_0=120, an island off SAmer is whacky
    - The edge-shadowing of cut-off side is ugly. But it would go away if we
      drew the earth edge, which is not a bad idea.

* 07_5.R looking at problem if lon_0 is -60

* 07_6.R as 07_5. but isolate data manually to just AA

* 08.R coastlineCut() trial version (local)

* 09.R coastlineCut() as incorporated into oce

* create_new_coastline.R create a new worldCoastline that might transform
  better. Three plot pages show the steps in how I inferred which parts of the
dataset to extract and how to reassemble them. I added 23 points circling very
close to the South pole.

* 10.R uses new coastline but otherwise as 09.R
