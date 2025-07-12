# Tests of logic to see whether rsk file has geodata. The proposed test
# indicates the presence of geodata if (a) that object is not NULL,
# (b) if it is a data frame and (c) that dataframe has 1 or more rows.

test <- function(geodata) {
    if (!is.null(geodata) && is.data.frame(geodata) && nrow(geodata) > 0) {
        cat("have geodata\n")
    } else {
        cat("do not have geodata\n")
    }
}
geodata <- NULL
test(geodata)

geodata <- data.frame(a = NULL, b = NULL)
test(geodata)

geodata <- data.frame()
test(geodata)

geodata <- data.frame(a = 1, b = 10)
test(geodata)
