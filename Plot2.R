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

TotalEmission_Year_bal <- ddply(PM25_Baltimore, .(year), summarize, total = sum(Emissions))
png(filename="plot2.png")

with(TotalEmission_Year_bal, plot(year, total/1000, xlab="Year", ylab = "Total Emissions - (kiloton)", 
                                  main = "Total PM2.5 Emissions Per Year for the City of Baltimore",  pch = 19, col = "blue"))

dev.off()