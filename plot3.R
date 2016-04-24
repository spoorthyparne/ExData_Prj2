NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(ggplot2)
library(plyr)
Baltimore_data <- subset(NEI, fips == "24510")
totals <- ddply(Baltimore_data, c("year","type"), summarise, total = sum(Emissions)/10^3)

png(filename='plot3.png')
ggp <- ggplot(totals, aes(x=factor(year), y=total, fill=type)) +
  geom_bar(aes(fill=year),stat="identity") +
  facet_grid(scales="free", space="free", .~type) +
  guides(fill=FALSE) + theme_bw() +
  labs(x="year", y=expression("Total PM"[2.5]*" Emission (Kilo-Tons)")) + 
  labs(title=expression("PM"[2.5]*" Motor Vehicle Source Emissions in Baltimore"))
print(ggp)
dev.off()
