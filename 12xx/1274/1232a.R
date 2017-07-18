library(oce)
options(digits=12, width=150)
data(section)
dhu <- swDynamicHeight(section, eos="unesco")
dhg <- swDynamicHeight(section, eos="g")
bad <- which(is.na(dhg$height))
cat("The secondof the following three stations gives NA for dyn height. Why?\n")
for (i in bad[1] + seq(-1, 1)) {
    cat("\n\n", rep("*", 100), "\n\n", sep="")
    s <- section[["station", i]]
    summary(s)
    plot(s, span=5000)
    cat("s dyn height (gsw): ", swDynamicHeight(s, eos="gsw"), "\n")
    print(data.frame(SP=s[["SP"]], t=s[["temperature"]], p=s[["pressure"]],
                     lon=s[["longitude"]], lat=s[["latitude"]],
                     SA=s[["SA"]], CT=s[["CT"]],
                     refpres=2000))
    cat("unesco gives dyn height: ", swDynamicHeight(s, eos="unesco"), "m\n")
    cat("gsw    gives dyn height: ", swDynamicHeight(s, eos="gsw"), "(converted to m)\n")
}
