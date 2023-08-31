# Two speeds (degrees/hour) for M1 type constituents, according to
# https://flaterco.com/files/xtide/Constituents-20170508.pdf
speedA <- 14.487410
speedB <- 14.492052
periodA <- 360 / speedA
periodB <- 360 / speedB
frequencyA <- 1/periodA
frequencyB <- 1/periodB
# repeat period (hours)
1/(1/frequencyA - 1/frequencyB)
