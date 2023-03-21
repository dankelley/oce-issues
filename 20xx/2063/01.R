library(oce)
files <- list.files(path="~/data/argo", pattern="*.nc", full.names=TRUE)
hasMTIME <- rep(FALSE, length.out=length(files))
for (ifile in seq_along(files)) {
    a <- read.argo(files[ifile])
    hasMTIME[ifile] <- "MTIME" %in% names(a@data)
}
df <- data.frame(file=files, hasMTIME=hasMTIME)
print(table(df$hasMTIME))
print(df[df$hasMTIME, ])
save(df, file="df.rda")
