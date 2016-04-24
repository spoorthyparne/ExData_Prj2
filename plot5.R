NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

mvSource = grepl("vehicle", SCC$SCC.Level.Two, ignore.case = TRUE)
mvRow = which(mvSource  == TRUE)
mvSCC = SCC[mvRow, 1]
mvNEI = NEI[NEI$SCC %in% mvSCC,]
balMV <- subset(mvNEI, fips == "24510")
totalEmission <- ddply(balMV, c("year"), summarise, total = sum(Emissions)/10^3)
png(filename='plot5.png')
barplot(totalEmission$total, names.arg = totalEmission$year, xlab = "Year", ylab = "Totals emmissions in kilotons" , main = "Total Emissions in Baltimore city for Motor Vehicles")
dev.off()