library(plyr)

url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
if(!file.exists("./NEI.zip")) {
    download.file(url, destfile="./NEI.zip")
    unzip("./NEI.zip")
}
SCCDataSet <- readRDS(file = "Source_Classification_Code.rds");
PM25DataSet <- readRDS(file = "summarySCC_PM25.rds");

PM25_Baltimore <- PM25DataSet[PM25DataSet$fips == "24510", ]

TotalEmission_Year_bal_byType <- ddply(PM25_Baltimore, c("year", "type"), summarise, total = sum(Emissions))

png(filename="plot3.png")

qplot(x = year, y = total, xlab = "Year", ylab = "Total Emissions (tons)",
      data = TotalEmission_Year_bal_byType,color = type, geom = c("point", "smooth"),
      method = "loess", main = "Total PM2.5 Emissions Per Year for the City of Baltimore by Type")

dev.off()