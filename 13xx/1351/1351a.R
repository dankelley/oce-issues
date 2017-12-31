library(testthat)

ttide <- read.table("ttide.dat", header=TRUE, skip=8, stringsAsFactors=FALSE)
## t_demo uses
## infername=['P1';'K2'];
## inferfrom=['K1';'S2'];
## infamp=[.33093;.27215];
## infphase=[-7.07;-22.40]

## Check amplitudes and phases for self-consistency (helps me to see what T-TIDE does)
expect_equal(ttide[ttide$Tide=="P1", "amplitude"],
             .33093*ttide[ttide$Tide=="K1", "amplitude"], tol=1e-5) # amp P1 from K1
expect_equal(ttide[ttide$Tide=="K2", "amplitude"],
             .27215*ttide[ttide$Tide=="S2", "amplitude"], tol=1e-5) # amp P1 from K1
expect_equal(ttide[ttide$Tide=="P1", "phase"],
             ttide[ttide$Tide=="K1", "phase"] - (-7.07), tol=1e-5) # amp P1 from K1
expect_equal(ttide[ttide$Tide=="K2", "phase"],
             ttide[ttide$Tide=="S2", "phase"] - (-22.40), tol=1e-5) # amp P1 from K1


