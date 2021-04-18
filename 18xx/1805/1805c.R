# Display oce.plot.ts() speedup using simplify.
# The '*Data' come from 1805a.R runs, varying the 'N' definition.
cutData <- "
  N    orig    new
1e3   0.157  0.161
1e3   0.158  0.162
1e3   0.153  0.160
1e4   0.248  0.387
1e4   0.236  0.374
1e4   0.247  0.389
1e5   1.646  0.429
1e5   1.688  0.426
1e5   1.687  0.435
1e6  12.397  0.593
1e6  12.938  0.649
1e6  11.970  0.583
1e7  55.722  2.290
1e7  55.937  2.290
1e7  55.958  2.502"

findIntervalData <- "
  N    orig    new
1e4   0.236  0.249
1e4   0.254  0.255
3e4   0.672  0.495
3e4   0.609  0.430
1e5   1.616  0.503
1e5   1.585  0.438
3e5   3.969  0.564
3e5   3.932  0.417
1e6  11.581  0.675
1e6  11.479  0.463
1e6  11.414  0.471
3e6  26.590  1.136
3e6  25.641  0.627
3e6  25.483  0.615
1e7  49.957  2.409
1e7  47.437  1.139
1e7  47.179  1.124
3e7  78.386  2.983
3e7  79.046  3.275
3e7  79.574  3.030
1e8 176.972 12.296
1e8 175.567 12.965
"

par(mfcol=c(2,1), mar=c(3,3,1,1), mgp=c(2,0.7,0))
d <- read.table(text=findIntervalData, header=TRUE)
plot(d$N, d$orig, log="x",
     xlab="", ylab="User Time [s]")
grid()
legend("topleft", col=1:2,
       legend=c("simplify=NA", "simplify=2560 (default)"), pch=1, bg="white")
points(d$N, d$new, col=2)
mtext("1805c.R, plotting results from 1805a.R", cex=par("cex"), adj=1)
plot(d$N, d$orig/d$new, log="x",
     xlab="Number of Data Points (log scale)", ylab="Time Reduction Factor")
grid()

