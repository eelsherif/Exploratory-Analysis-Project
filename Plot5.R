library(plyr)
library(ggplot2)

url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
if(!file.exists("./NEI.zip")) {
    download.file(url, destfile="./NEI.zip")
    unzip("./NEI.zip")
}
SCCDataSet <- readRDS(file = "Source_Classification_Code.rds");
PM25DataSet <- readRDS(file = "summarySCC_PM25.rds");

PM25_Baltimore <- PM25DataSet[PM25DataSet$fips == "24510", ]

VehiclesRelated <- SCCDataSet[grepl("Vehicles", SCCDataSet$EI.Sector),]
PM25_Baltimore_Vehicle <- PM25_Baltimore[PM25_Baltimore$SCC %in% VehiclesRelated$SCC,]

VehiclesEmissionByYear <- ddply(PM25_Baltimore_Vehicle , .(year), summarize, total = sum(Emissions))

png(filename="plot5.png")

qplot(x = year, y = total, xlab = "Year", ylab = "Total Emissions (tons)",
      data = VehiclesEmissionByYear, geom = c("point", "smooth"),
      method = "loess", main = "Total PM2.5 Vehicles Emissions From Coal Related Sources")

dev.off()