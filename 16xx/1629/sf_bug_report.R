## skip the code so 'make' works here. I sent the report, and this has
## been addressed.
if (FALSE) {
    ## Show that sf_project() fails at south pole, with Lambert Conic Conformal projection
    library(sf)
    from <- "+proj=longlat"
    to <- "+proj=lcc +lat_0=30 +lat_1=60"
    tol <- 1e-4
    try(sf::sf_project(from, to, cbind(0, 90))) # OK
    try(sf::sf_project(from, to, cbind(0, -90))) # fails
    for (power in seq(-8, -11)) {
        eps <- 10^power
        cat(sprintf("eps=%15.12e\n", eps))
        try(sf::sf_project(from, to, cbind(0, -90 + eps)))
    }
}

