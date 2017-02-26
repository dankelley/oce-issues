## This test uses PRIVATE data, and cannot be run except for the developers and
## an issue reporter.
library(oce)
library(testthat)

if (1 == length(list.files(path="../696", pattern="data.ENX"))) {
    d <- read.oce("../696/data.ENX") # PRIVATE DATA
    ## The numbers from DK reading of "Teledyne RDI VmDas" screen snapshot CR provided, viz
    ##   https://cloud.githubusercontent.com/assets/233584/8739768/0c8ba9c0-2c0e-11e5-8ffa-3c3f40bc9cc5.png
    ## with 'scale' and 'tolerance' set to match the digits used on the GUI.
    expect_equal(d[['avgSpeed']][2], 0)    # The GUI shows "Avg/Mag ----"
    expect_equal(d[['avgTrackTrue']][2], 0)   # The GUI shows "Avg/Dir ----"
    expect_equal(d[['speedMadeGood']][2], 0.574) # The GUI shows "Made good/Mag 0.574"
    expect_equal(d[['directionMadeGood']][2], 321.0-360, scale=1, tolerance=0.1)
    ## sNavTime is called "Start Time" in GUI
    ## NB. It seems, from the test GUI, that times in the gui might be truncated, instead
    ## of rounding down, so the tolerance is set at 1 second.
    expect_equal(d[['firstTime']][2], as.POSIXct("2012-11-14 9:20:10", tz="UTC"), scale=1, tolerance=1)
    ## firstLatitude is called "Start Lat" in GUI
    expect_equal(d[['firstLatitude']][2], 53+(25+34/60)/60, scale=1, tolerance=1/3600)
    ## firstLongitude is called "Start Lon" in GUI
    expect_equal(d[['firstLongitude']][2], -(3+(0+26/60)/60), scale=1, tolerance=1/3600)
    expect_equal(d[['lastTime']][2], as.POSIXct("2012-11-14 9:20:22", tz="UTC"), scale=1, tolerance=0.5)
    expect_equal(d[['lastLatitude']][2], 53+(25+35/60)/60, scale=1, tolerance=1/3600)
    expect_equal(d[['lastLongitude']][2], -(3+(0+27/60)/60), scale=1, tolerance=1/3600)
    expect_equal(d[['heading']][2], 346.92, scale=1, tolerance=0.01)
    expect_equal(d[['pitch']][2], 0, scale=1, tolerance=0.01) # GUI lists as ----
    expect_equal(d[['roll']][2], 0, scale=1, tolerance=0.01) # GUI list as ----
} else {
    message("Cannot run tests for issue 704 without private test data")
}
