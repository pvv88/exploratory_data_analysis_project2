
setwd("C:/Users/Dell/Downloads")
sourceURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(sourceURL,'rawdata_eda.zip')
zFiles <- unzip(zipfile ="rawdata_eda.zip")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_classification_Code.rds")
NEI_A <- subset(NEI, fips == "24510" & type =="ON-ROAD")
summarizeA <- with(NEI_A,aggregate(Emissions, by = list(year, fips),sum))
NEI_B <- subset(NEI, fips == "06037" & type =="ON-ROAD")
summarizeB <- with(NEI_B,aggregate(Emissions, by = list(year, fips),sum))
png("plot6.png")
summarize <- rbind(summarizeA,summarizeB)
colnames(summarize) <- c("Year","Fips", "Emissions")
library(ggplot2)
library(grid)
qplot(data = summarize,
      Year,
      Emissions,
      color = Fips,
      ylab = expression("Total"~ PM[2.5] ~"Emissions"),
      xlab = "Years",
      main = expression("Total" ~PM[2.5] ~"Emissions in Baltimore City, 1999-2008"),
      geom = "line") + 
  theme(plot.margin = unit(c(1,1,2,1), "cm"))
grid.text((paste("Based on the graph, Baltimore emissions are significantly lower than Los Angeles City. From 1999")),
          x = unit(.05, "npc"), y = unit(.08, "npc"), just = c("left", "bottom"), 
          gp = gpar(fontsize = 9, fontface= 3))
grid.text((paste("to 2008, Baltimore emissions continue to improve from 348 to 88 compared with Los Angeles,")),
          x = unit(.05, "npc"), y =unit(.06, "npc"), just = c("left", "bottom"), 
          gp = gpar(fontsize = 9, fontface= 3))
grid.text((paste("that went high from 3,931 to 4,101 in 2008")),
          x = unit(.05, "npc"), y =unit(.04, "npc"), just = c("left", "bottom"), 
          gp = gpar(fontsize = 9, fontface= 3))
dev.off()