## Test how layout() affects par('pin') and par('fin')
x <- 1:10
y <- 2*x
for (d in c(0.5, 0.3)) {
    layout(matrix(1, nrow=1), widths=1)
    cat("TEST layout(..., widths=c(", 1-d, ",", d, "))\n")
    cat("  pin=", par("pin"), "before layout\n")
    cat("  fin=", par("fin"), "before layout\n\n")
    layout(matrix(c(1, 2), nrow=1), widths=c(1-d, d))

    frame(); par(new=TRUE)

    cat("  pin=", par("pin"), "before plot 1\n")
    cat("  fin=", par("fin"), "before plot 1\n\n")
    plot(x, y, xlab="PLOT 1")

    frame(); par(new=TRUE)

    cat("  pin=", par("pin"), "after plot 1, i.e. just before plot 2\n")
    cat("  fin=", par("fin"), "after plot 1, i.e. just before plot 2\n\n")
    plot(x, y, xlab="PLOT 2")
    cat("  pin=", par("pin"), "after plot 2\n")
    cat("  fin=", par("fin"), "after plot 2\n\n")
}

