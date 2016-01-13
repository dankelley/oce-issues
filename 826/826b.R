# Demonstrate RStudio problem with margins.
#
# GOAL: create a 1-inch wide plot, near right edge of plot area.
#
# MACHINE: OSX (macbook pro, retina, 13-inch)
#
# TEST 1: APP 2: R 3.2.3 GUI 1.66 Mavericks build (7060)
# RESULT 1: works as expected
#
# TEST 2: RStudio 0.99.842
# RESULT 2: ERROR 'figure margins too large'

m <- 0.5
pin <- par('pin')
mai <- c(m, pin[1]-2*m, m, m)
print(pin)
print(mai)
par(mai=mai)
plot(1:10, 1:10)

