# Display oce.plot.ts() speedup using simplify.
timing <- "
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
d <- read.table(text=timing, header=TRUE)
par(mfrow=c(2,1), mar=c(3,3,1,1), mgp=c(2,0.7,0))
plot(d$N, d$orig, type="o", log="x",
     xlab="Number of Data Points", ylab="User Time [s]")
legend("topleft", col=1:2, legend=c("Unsimplified", "Simplified"), pch=1, lwd=1)
points(d$N, d$new, type="o", col=2)
plot(d$N, d$orig/d$new, type="o", log="x",
     xlab="Number of Data Points", ylab="Time Reduction Factor")
