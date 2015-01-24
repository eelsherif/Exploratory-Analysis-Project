library(plyr)
library(ggplot2)

url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
if(!file.exists("./NEI.zip")) {
    download.file(url, destfile="./NEI.zip")
    unzip("./NEI.zip")
}
SCCDataSet <- readRDS(file = "Source_Classification_Code.rds");
PM25DataSet <- readRDS(file = "summarySCC_PM25.rds");

PM25 <- PM25DataSet[PM25DataSet$fips == "24510" | fips == "06037", ]


VehiclesRelated <- SCCDataSet[grepl("Vehicles", SCCDataSet$EI.Sector),]
PM25_Vehicle <- PM25[PM25$SCC %in% VehiclesRelated$SCC,]

VehiclesEmissionByYear <- ddply(PM25_Vehicle , .(year, fips), summarize, total = sum(Emissions))
VehiclesEmissionByYear$city <- ifelse(VehiclesEmissionByYear$fips == "24510", "Baltimore", "Los Angeles")

png(filename="Plot6.png")

qplot(x = year, y = total, xlab = "Year", ylab = "Total Emissions (tons)",
      data = VehiclesEmissionByYear, color = city ,geom = c("point", "smooth"),
      method = "loess", main = "Total PM2.5 Vehicles Emissions From Coal Related Sources")

dev.off()