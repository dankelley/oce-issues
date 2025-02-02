library(oce)
library(RSQLite)
filename <- "test.rsk"
# 1. use oce to look at data
rsk <- read.rsk(filename)
names(rsk@data)
summary(rsk)
# see first few values
head(rsk)

# 2. look directly at data
con <- DBI::dbConnect(RSQLite::SQLite(), dbname = filename)
print(RSQLite::dbListTables(con))
channelNames <- DBI::dbListFields(con, "data")
print(channelNames)
options(width = 200) # to avoid line breaks in next printed item
channels <- RSQLite::dbReadTable(con, "channels")
print(channels)
channelID <- gsub("channel[0]*", "", channelNames)
print(channelID)
keep <- channels$channelID %in% channelID
channelsNew <- channels[keep, ]
print(channelsNew)
