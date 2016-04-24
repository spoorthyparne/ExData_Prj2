NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

mvSource = grepl("vehicle", SCC$SCC.Level.Two, ignore.case = TRUE)
mvRow = which(mvSource  == TRUE)
mvSCC = SCC[mvRow, 1]
mvNEI = NEI[NEI$SCC %in% mvSCC,]
balMV <- subset(mvNEI, fips == "24510")
laMV <- subset(mvNEI, fips == "06037")
src = rbind(balMV, laMV)

png(filename='plot6.png')
ggp <- ggplot(src, aes(x=factor(year), y=Emissions, fill=fips)) +
  geom_bar(aes(fill=year),stat="identity") +
  facet_grid(scales="free", space="free", .~fips) +
  guides(fill=FALSE) + theme_bw() +
  labs(x="year", y=expression("Total PM"[2.5]*" Emission (Kilo-Tons)")) + 
  labs(title=expression("PM"[2.5]*" Motor Vehicle Source Emissions in Baltimore Vs LA"))
print(ggp)
dev.off()

