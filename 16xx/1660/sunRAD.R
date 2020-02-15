library(oce)
#' Sun Declination and Right Ascension
#'
#' The formulae are from Meeus (1991), mainly chapter 24.
#'
#' @param time a POSIXct time. This ought to be in UTC timezone; if not,
#' the behaviour of this function is unlikely to be correct.
#'
#' @param apparent logical value indicating whether to return
#' the 'apparent' angles.
#'
#' @return A list containing `declination` and `rightAscension`, in degrees.
#'
#' @examples
#' ## Example 24.a in Meeus (1991) (page 158 PDF, 153 print)
#' time <- as.POSIXct("1992-10-13 00:00:00", tz="UTC")
#' a <- sunDeclinationRightAscension(time, apparent=TRUE)
#' expect_equal(a$declination, -7.78507,
#'              tol=            0.00004, scale=1)
#' expect_equal(a$rightAscension, -161.61919,
#'              tol=                 0.00003, scale=1)
#' b <- sunDeclinationRightAscension(time)
#' ## check against previous results, to protect aginst code-drift errors
#' expect_equal(b$declination, -7.785464443,
#'              tol=            0.000000001, scale=1)
#' expect_equal(b$rightAscension, -161.6183305,
#'              tol=                 0.0000001, scale=1)
#'
#' @references
#' 1. Meeus, Jean H. Astronomical Algorithms. 2nd ed. Willmann-Bell, Incorporated, 1991.
#'
#' @author Dan Kelley, based on formulae in Meeus (1991).
sunDeclinationRightAscension <- function(time, apparent=FALSE)
{
    year <- as.numeric(format(time, "%Y"))
    k <-  2 * pi / 360                     # k*degrees == radians
    ## Meeus 1991 pdf page 158, print page 153
    JD <- julianDay(time)
    T <- (JD - 2451545.0) / 36525          # Meeus (1991) eq (24.1)
    ## L0 = geometric mean longitude of sun, referred to mean equinox of date
    L0 <- 280.46645 + 36000.76983*T + 0.0003032*T^2 # Meeus (1991) eq (24.2)
    L0 <- L0 %% 360
    ## mean anomaly of sun
    M <- 357.52910 + 35999.05030*T - 0.0001558*T^2 - 0.00000048*T^3
    M <- M %% 360
    ## e = eccentricity of earth's orbit, Meeus (1991) first unnumbered eqn after (24.4)
    e <- 0.016708617 - 0.000042037*T - 0.0000001236*T^2
    ## sun equation of center C
    C <- (1.914600-0.004817*T-0.000014*T^2)*sin(k*M) + (0.019993-0.000101*T)*sin(k*2*M) + 0.000290*sin(3*k*M)
    ## sun true longitude: Meeus (1991) second eqn after eqn (24.4)
    Theta <- L0 + C
    ## sun true anomaly
    nu <- M + C
    ## sun radius vector (dist earth to sun, in AU)
    R <- (1.000001018 * (1 - e^2)) / (1 + e * cos(k * nu))
    ## first unnumbered eqn after Meeus (1991) eqn (24.5)
    Omega <- 125.04 - 1934.136 * T
    ## second unnumbered eqn after Meeus (1991) eqn (24.5)
    lambda <- Theta - 0.00569 - 0.00478 * sin(k*Omega)
    ## Theta2000 defined but not used
    Theta2000 <- Theta - 0.01397 * (year - 2000)
    ## epsilon: Meeus (1991) eqn (21.1) (PDF page 140, print page 135)
    ## mean obliquity of ecliptic
    epsilon0 <- 23+(26+21.448/60)/60 - 46.8150/60^2*T - 0.00059/60^2*T^2 + 0.001813/60^2*T^3
    L <- 280.4665 + 36000.7698*T           # Meeus (1991) PDF page 137, print page 132
    Lprime <- 218.3165 + 481267.8813*T     # Meeus (1991) PDF page 137, print page 132
    ## NOT same Omega as above, but we are following the trail of equations step by step,
    ## and the following actually passes the test above so perhaps the previous eqn for
    ## Omega was an approximation.
    ## Omega <- 125.04452 - 1934.136261*T + 0.0020708*T^2 + T^3/450000 # Meeus (1991) PDF page 137, print page 132
    ## But he then says to drop the T^2 and T^3 terms before giving the DeltaEpsilon eqn, so we do that.
    Omega <- 125.04452 - 1934.136261*T # Meeus (1991) PDF page 137, print page 132
    DeltaEpsilon <- 9.20/60^2*cos(k*Omega) + 0.57/60^2*cos(k*2*L) + 0.10/60^2*cos(k*2*Lprime) - 0.09/60^2*cos(k*2*Omega)
    epsilon <- epsilon0 + DeltaEpsilon
    ## alpha Meeus (1991)  eqn (24.6) PDF page 158, print page 153
    if (apparent) {
        epsilonA <- epsilon + 0.00256*cos(k*Omega)
        alpha <- 1/k * atan2(cos(k*epsilonA) * sin(k*lambda), cos(k*lambda))
        delta <- 1/k * asin(sin(k*epsilonA) * sin(k*lambda)) # Meeus (1991) eqn (24.7) (PDF 1ige 58 print page 153)
    } else {
        alpha <- 1/k * atan2(cos(k*epsilon) * sin(k*Theta), cos(k*Theta))
        delta <- 1/k * asin(sin(k*epsilon) * sin(k*Theta)) # Meeus (1991) eqn (24.7) (PDF 1ige 58 print page 153)
    }
    list(declination=delta, rightAscension=alpha)
}
## Example 24.a in Meeus (1991) (page 158 PDF, 153 print)
time <- as.POSIXct("1992-10-13 00:00:00", tz="UTC")
a <- sunDeclinationRightAscension(time, apparent=TRUE)
expect_equal(a$declination, -7.78507,
             tol=            0.00004, scale=1)
expect_equal(a$rightAscension, -161.61919,
             tol=                 0.00003, scale=1)
b <- sunDeclinationRightAscension(time)
## check against previous results, to protect aginst code-drift errors
expect_equal(b$declination, -7.785464443,
             tol=            0.000000001, scale=1)
expect_equal(b$rightAscension, -161.6183305,
             tol=                 0.0000001, scale=1)

