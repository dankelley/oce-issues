## Test how layout() affects par('pin') and par('fin')
for (d in c(0.3, 0.5)) {
    layout(matrix(1, nrow=1), widths=1)
    cat("BEFORE LAYOUT:\n")
    cat("  pin=", par("pin"), "\n")
    cat("  fin=", par("fin"), "\n")
    layout(matrix(c(1, 2), nrow=1), widths=c(1-d, d))
    cat("AFTER LAYOUT with widths=c(", 1-d, ",", d, ")\n")
    cat("  pin=", par("pin"), "before plot 1\n")
    cat("  fin=", par("fin"), "before plot 1\n")
    plot(1:3)
    cat("  pin=", par("pin"), "before plot 2\n")
    cat("  fin=", par("fin"), "before plot 2\n")
    plot(1:3)
    cat("  pin=", par("pin"), "after plot 2\n")
    cat("  fin=", par("fin"), "after plot 2\n")
    cat("\n")
}

