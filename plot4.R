NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

combustion = grepl("comb", SCC$Short.Name, ignore.case = TRUE)
coal = grepl("coal", SCC$Short.Name, ignore.case = TRUE)
coal_comb = which(combustion & coal  == TRUE)
coalCombSCC = SCC[coal_comb,1]
coalCombNEI = NEI[NEI$SCC %in% coalCombSCC,]
totalEmission <- ddply(coalCombNEI, c("year"), summarise, total = sum(Emissions)/10^3)
png(filename='plot4.png')
barplot(totalEmission$total, names.arg = totalEmission$year, xlab = "Year", ylab = "Totals emmissions in kilotons", main = "Total Emissions in US")
dev.off()
