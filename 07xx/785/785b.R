## originally ../777/777b.R
if (!interactive()) png("785b.png")
library(oce)
library(testthat)
file <- "MS2015-150kHz002_000001.ENX"
if (1 == length(list.files(pattern=file))) {
    ## easier to debug without skipping through the file
    #d <- read.adp.rdi(file, from=1, to=3, debug=3)
    d <- read.adp.rdi(file, from=1, to=300)
    expect_true('br' %in% names(d@data), info="This file should have bottom range, br")
    expect_true('bv' %in% names(d@data), info="This file should have bottom velocity, bv")

    ## Compare with results from Rich Pawlocicz' matlab code (via CR)
    BR <- matrix(scan(text="305.0300  309.3000  309.3000  302.9000
                      305.0300  309.3000  313.5600  302.9000
                      305.0300  309.3000  311.4300  300.7600
                      305.0300  307.1600  311.4300  300.7600
                      309.3000  305.0300  311.4300  298.6300
                      307.1600  307.1600  311.4300  305.0300
                      305.0300  307.1600  311.4300  302.9000
                      307.1600  309.3000  311.4300  302.9000
                      305.0300  307.1600  309.3000  302.9000
                      307.1600  307.1600  311.4300  302.9000", quiet=TRUE),
                      byrow=TRUE, nrow=10)
    expect_equal(d[['br']][1:10,], BR)

    BV <- matrix(scan(text="1133       -5858         306         -35
                      1097       -5759        -118          40
                      1089       -5745         122          -9
                      1058       -5778         -39          28
                      1008       -5740          62         -26
                      1010       -5847         -65         -52
                      1083       -5754         291          10
                      1040       -5889        -210         -41
                      1118       -5766         297         -13
                      1006       -5815         -47           8", quiet=TRUE)/1000,
                      byrow=TRUE, nrow=10)
    expect_equal(d[['bv']][1:10,], BV)



    par(mfrow=c(2,5))
    plot(d, which="bottomRange")
    plot(d, which="bottomRange1")
    plot(d, which="bottomRange2")
    plot(d, which="bottomRange3")
    plot(d, which="bottomRange4")
    plot(d, which="bottomVelocity")
    plot(d, which="bottomVelocity1")
    plot(d, which="bottomVelocity2")
    plot(d, which="bottomVelocity3")
    plot(d, which="bottomVelocity4")
} else {
    message("cannot run the test in 777a.R because it needs a file named ", file)
}
if (!interactive()) dev.off()
