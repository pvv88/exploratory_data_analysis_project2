
setwd("C:/Users/Dell/Downloads")
sourceURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(sourceURL,'rawdata_eda.zip')
zFiles <- unzip(zipfile ="rawdata_eda.zip")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_classification_Code.rds")
newNEI <- subset(NEI, fips == "24510" & type =="ON-ROAD")
summarize <- with(newNEI,aggregate(Emissions, by = list(year),sum))
png("plot5.png")
colnames(summarize) <- c("Year","Emissions")
library(ggplot2)
library(grid)
qplot(data = summarize,
      Year,
      Emissions,
      ylab = expression("Total"~ PM[2.5] ~"Emissions"),
      xlab = "Years",
      main = expression("Total" ~PM[2.5] ~"Emissions in Baltimore City, 1999-2008"),
      geom = "line") + 
  theme(plot.margin = unit(c(1,1,2,1), "cm"))
grid.text((paste("In 1999, emissions was just 347 that significantly decreased to 134 in 2002. Emissions was steady")),
          x = unit(.05, "npc"), y = unit(.08, "npc"), just = c("left", "bottom"), 
          gp = gpar(fontsize = 9, fontface= 3))
grid.text((paste("from 2002 to 2005 and decreased slightly from 2005 to 2008.")),
          x = unit(.05, "npc"), y =unit(.06, "npc"), just = c("left", "bottom"), 
          gp = gpar(fontsize = 9, fontface= 3))
dev.off()