# Issue 416: imagep and layout issues with regular "paletted" plots

Now that `drawPalette(..., fullpage=TRUE)` works with `layout` (see [https://github.com/dankelley/oce/issues/413]), it seemed to me that I should test how well the "standard" `imagep()` plots with with `layout()` -- conceivably one might want to use `layout` to make a complicated grid of plots with different sizes (which is not possible with e.g. `par(mfrow=...)`).

It appears as though the standard `imagep()` call, when preceded by a `layout()`, causes the palette to fill the entire panel *behind* the image plot. See the code below (and in `416A.R`):

```splus
rm(list=ls())
library(oce)

d <- 0.3

if (!interactive()) png('416A.png')
layout(matrix(c(1, 2), nrow=1), widths=c(1-d, d))

## first panel
imagep(volcano, drawPalette=TRUE)

## second panel
imagep(volcano, drawPalette=FALSE) # fails because of "margins too
                                   # large" error if
                                   # `drawPalette=TRUE`, presumably
                                   # because 0.3 is just not wide
                                   # enough for a proper imagep plot

if (!interactive()) dev.off()
```
