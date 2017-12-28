library(testthat)

ttide <- read.table("ttide.dat", header=TRUE, skip=8, stringsAsFactors=FALSE)
## t_demo uses
## infername=['P1';'K2'];
## inferfrom=['K1';'S2'];
## infamp=[.33093;.27215];
## infphase=[-7.07;-22.40]

## Check amplitudes (using the infamp field)
expect_equal(ttide[ttide$Tide=="P1", "Amp"], .33093*ttide[ttide$Tide=="K1", "Amp"], tol=1e-5) # amp P1 from K1
expect_equal(ttide[ttide$Tide=="K2", "Amp"], .27215*ttide[ttide$Tide=="S2", "Amp"], tol=1e-5) # amp P1 from K1
## Check phases (using the infphase field)
expect_equal(ttide[ttide$Tide=="P1", "Pha"], ttide[ttide$Tide=="K1", "Pha"] - (-7.07), tol=1e-5) # amp P1 from K1
expect_equal(ttide[ttide$Tide=="K2", "Pha"], ttide[ttide$Tide=="S2", "Pha"] - (-22.40), tol=1e-5) # amp P1 from K1


