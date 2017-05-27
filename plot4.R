
setwd("C:/Users/Dell/Downloads")
sourceURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(sourceURL,'rawdata_eda.zip')
zFiles <- unzip(zipfile ="rawdata_eda.zip")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_classification_Code.rds")
coal <- grepl("coal", SCC$Short.Name, ignore.case = TRUE)
newSCC <- SCC[coal,]
mergeRDS <- merge(NEI, newSCC, by= "SCC")
summarize <- with(mergeRDS,aggregate(Emissions, by = list(year),sum))
png("plot4.png")
colnames(summarize) <- c("Year","Emissions")
library(ggplot2)
library(grid)
qplot(data = summarize,
      Year,
      Emissions,
      ylab = expression("Total"~ PM[2.5] ~"Emissions"),
      xlab = "Years",
      main = expression("Total" ~PM[2.5] ~"Emissions from 1999-2008"),
      geom = "line") + 
  theme(plot.margin = unit(c(1,1,2,1), "cm"))
grid.text((paste("There is a slight decrease of emission from 1999 to 2000 then goes steady from 2002 to 2005 and")),
          x = unit(.05, "npc"), y = unit(.08, "npc"), just = c("left", "bottom"), 
          gp = gpar(fontsize = 9, fontface= 3))
grid.text((paste("decreased considerably from  2005 to 2008.")),
          x = unit(.05, "npc"), y =unit(.06, "npc"), just = c("left", "bottom"), 
          gp = gpar(fontsize = 9, fontface= 3))
dev.off()