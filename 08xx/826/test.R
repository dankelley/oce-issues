# Demonstrate RStudio problem with margins.
#
# GOAL: create a w=1-inch wide plot, near right edge of plot area, with a m=0.5 inch margin
# at bottom, right, and top. Do this by setting the left-hand margin to 
# par('pin)'-w-m, and the right-hand margin to m.
#
# MACHINE: OSX (macbook pro, retina, 13-inch)
#
# TEST 1: APP 2: R 3.2.3 GUI 1.66 Mavericks build (7060)
# RESULT 1: plot is as expected
#    > print(pin)
#    [1] 3.76 3.16
#    > print(mai)
#    [1] 0.50 2.26 0.50 0.50
#    > par('mai')
#    [1] 1.02 0.82 0.82 0.42
#    > par('csi')
#    [1] 0.2
#    > par('cra')
#    [1] 10.8 14.4
#    > par('mai')
#    [1] 0.50 2.26 0.50 0.50
#
# TEST 2: RStudio 0.99.842
# RESULT 2: no plot; instead the error 'figure margins too large'
#    > print(pin)
#    [1] 12.121111  4.951667
#    > print(mai)
#    [1]  0.50000 10.62111  0.50000  0.50000
#    > par('mai')
#    [1] 1.02 0.82 0.82 0.42
#    > par('csi')
#    [1] 0.2
#    > par('cra')
#    [1] 10.8 14.4
#    > par('mai')
#    [1]  0.50000 10.62111  0.50000  0.50000

m <- 0.5 # margin at bottom, top, and right
w <- 1.0 # inside width of plot
pin <- par('pin')
mai <- c(m, pin[1] - w - m, m, m)
print(pin)
print(mai)
par('mai')
par('csi')
par('cra')
par(mai=mai)
par('mai')
plot(1:10, 1:10)
sessionInfo()
#RStudio.Version()
print(par())

