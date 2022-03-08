library(oce)
T <- 1
p <- 0.2
C <- 1
options(oceEOS="gsw")
S <- swSCTp(C, T, p, conductivityUnit="mS/cm")
Su <- swSCTp(C, T, p, conductivityUnit="mS/cm", eos="unesco")
Sg <- swSCTp(C, T, p, conductivityUnit="mS/cm", eos="gsw")
cat(sprintf("With oceEOS=gsw:\n  S=%.5f Su=%.5f Sg=%.5f\n", S, Su, Sg))
options(oceEOS="unesco")
S <- swSCTp(C, T, p, conductivityUnit="mS/cm")
Su <- swSCTp(C, T, p, conductivityUnit="mS/cm", eos="unesco")
Sg <- swSCTp(C, T, p, conductivityUnit="mS/cm", eos="gsw")
cat(sprintf("With oceEOS=unesco:\n  S=%.5f Su=%.5f Sg=%.5f\n", S, Su, Sg))

