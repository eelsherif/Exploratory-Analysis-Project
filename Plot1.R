library(plyr)

url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
if(!file.exists("./NEI.zip")) {
    download.file(url, destfile="./NEI.zip")
    unzip("./NEI.zip")
}

SCCDataSet <- readRDS(file = "Source_Classification_Code.rds");
PM25DataSet <- readRDS(file = "summarySCC_PM25.rds");

TotalEmission_Year <- ddply(PM25DataSet, .(year), summarize, total = sum(Emissions))

png(filename="plot1.png")
with(TotalEmission_Year, plot(year, total/1000, xlab="Year", ylab = "Total Emissions - (kiloton)", 
        main = "Total PM2.5 Emissions Per Year", pch = 19, col = "blue"))

dev.off()