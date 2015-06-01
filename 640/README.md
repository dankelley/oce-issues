The files here won't mean much except to the author or others who are familiar
with C.

* *.R before 06: some have a nice tracing method with code that will possibly
  be useful ater on.

* 06.R simple polygon chopper, made-up island with moving cut point

* 07.R / polygon3.c -- simple polygon chopper with coastlineWorld. Bugs:
    - A few cases have UHL, e.g. for lon_0=120, an island off SAmer is whacky
    - The edge-shadowing of cut-off side is ugly. But it would go away if we
      drew the earth edge, which is not a bad idea.

* 08.R coastlineCut() trial version (local)

* 09.R coastlineCut() as incorporated into oce

