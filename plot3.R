
setwd("C:/Users/Dell/Downloads")
sourceURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(sourceURL,'rawdata_eda.zip')
zFiles <- unzip(zipfile ="rawdata_eda.zip")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_classification_Code.rds")
NEI_24510 <- NEI[which(NEI$fips == "24510"),] 
summarize <- with(NEI_24510,aggregate(Emissions, by = list(type,year),sum))
png("plot3.png")
colnames(summarize) <- c("Type","Year","Emissions")
library(ggplot2)
library(grid)
qplot(data = summarize,
      Year,
      Emissions,
      color = Type,
      ylab = expression("Total"~ PM[2.5] ~"Emissions"),
      xlab = "Years",
      main = expression("Total" ~PM[2.5] ~"Emissions by Type, 1999-2008"),
      geom = "line") + 
  theme(plot.margin = unit(c(1,1,4.5,1), "cm"))
grid.text((paste("NON-ROAD: Decreased slightly from 1999 to 2000 then goes steady from 2002 to 2005 and decreased")),
          x = unit(.05, "npc"), y = unit(.2, "npc"), just = c("left", "bottom"), 
          gp = gpar(fontsize = 9, fontface= 3))
grid.text((paste("from  2005 to 2008.")),
          x = unit(.05, "npc"), y = unit(.18, "npc"), just = c("left", "bottom"), 
          gp = gpar(fontsize = 9, fontface= 3))
grid.text((paste("NONPOINT: Decreased considerably from 1999 to 2002 then goes steady from 2002 to 2005 and decreased")),
          x = unit(.05, "npc"), y = unit(.15, "npc"), just = c("left", "bottom"), 
          gp = gpar(fontsize = 9, fontface= 3))
grid.text((paste("from 2005 to 2008.")),
          x = unit(.05, "npc"), y = unit(.13, "npc"), just = c("left", "bottom"), 
          gp = gpar(fontsize = 9, fontface= 3))
grid.text((paste("ON-ROAD: Decreased slightly from 1999 to 2000 then goes steady from 2002 to 2005 and decreased")),
          x = unit(.05, "npc"), y = unit(.10, "npc"), just = c("left", "bottom"), 
          gp = gpar(fontsize = 9, fontface= 3))
grid.text((paste("from  2005 to 2008.")),
          x = unit(.05, "npc"), y = unit(.08, "npc"), just = c("left", "bottom"), 
          gp = gpar(fontsize = 9, fontface= 3))
grid.text((paste("POINT: Increased slightly from 1999 to 2002 then considerably increase from 2002 to 2005 and decreased")),
          x = unit(.05, "npc"), y = unit(.05, "npc"), just = c("left", "bottom"), 
          gp = gpar(fontsize = 9, fontface= 3))
grid.text((paste("greatly from 2005 to 2008")),
          x = unit(.05, "npc"), y = unit(.03, "npc"), just = c("left", "bottom"), 
          gp = gpar(fontsize = 9, fontface= 3))
dev.off() 