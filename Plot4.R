library(plyr)
library(ggplot2)

url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
if(!file.exists("./NEI.zip")) {
    download.file(url, destfile="./NEI.zip")
    unzip("./NEI.zip")
}
SCCDataSet <- readRDS(file = "Source_Classification_Code.rds")
PM25DataSet <- readRDS(file = "summarySCC_PM25.rds")

coalRelatedSources <- SCCDataSet[grepl("Coal", SCCDataSet$EI.Sector),]

PM25DataSet_Coal <- PM25DataSet[PM25DataSet$SCC %in% coalRelatedSources$SCC,]

CoalEmissionByYear <- ddply(PM25DataSet_Coal, .(year), summarize, total = sum(Emissions))

png(filename="plot4.png")

qplot(x = year, y = total, xlab = "Year", ylab = "Total Emissions (tons)",
      data = CoalEmissionByYear, geom = c("point", "smooth"),
      method = "loess", main = "Total PM2.5 Emissions From Coal Related Sources")

dev.off()
