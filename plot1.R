
setwd("C:/Users/Dell/Downloads")
sourceURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(sourceURL,'rawdata_eda.zip')
zFiles <- unzip(zipfile ="rawdata_eda.zip")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_classification_Code.rds")

summarize <- with(NEI, aggregate(Emissions, by = list(year),sum))
colnames(summarize) <- c("Year", "Emissions")
png("plot1.png")
par(mar= c(8,5,5,5))
plot1 <- plot(y = summarize$Emissions,
              x = summarize$Year, 
              type = "o",
              ylab = expression("Total"~ PM[2.5] ~"Emissions"),
              xlab = "Years",
              pch = 18,
              main = expression("Total" ~PM[2.5] ~"Emissions, 1999-2008"),
              col = "red")
mtext(" The total emissions in the US has decreased from 1998 to 2008",
      side=1,
      outer=T,
      adj=0.1,
      line=-4, 
      font = 3,
      cex = 0.8) 
dev.off()