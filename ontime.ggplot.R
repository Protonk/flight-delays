library(plyr)
library(reshape2)
library(scales)
library(ggplot2)

qplot(UNIQUE_CARRIER, nrow, data = carr.df, geom = "bar") +
  scale_y_continuous(name = "Flights in January") + scale_x_discrete(name = '')

qplot(`Mean Delay`, `Proportion on Time`, data = carr.df, colour = UNIQUE_CARRIER, geom = "text", label = UNIQUE_CARRIER, size = nrow) + scale_colour_discrete(guide = "none") + scale_size_continuous(guide = "none", range=c(4,12)) + scale_x_continuous(name = "Mean Arrival Delay") + scale_y_continuous(name = "Probability of Arrival within 5 min of Schedule")

qplot(`Median Delay`, `Proportion on Time`, data = carr.df, colour = UNIQUE_CARRIER, geom = "text", label = UNIQUE_CARRIER, size = nrow) + scale_colour_discrete(guide = "none") + scale_size_continuous(guide = "none", range=c(4,12)) + scale_x_continuous(name = "Median Arrival Delay") + scale_y_continuous(name = "Probability of Arrival within 5 min of Schedule")


ggplot(data = avgplot.df, aes(x = Carrier, y = value, fill = Measure)) +
  geom_bar(data = avgplot.df, width=0.8, position = position_dodge(width=0.8)) +
  scale_x_discrete(name = '') + scale_y_continuous(name = "Minutes") +
  opts(
    axis.text.x=theme_text(angle= 45, hjust= 0.2, vjust = 0.2, size = 15)
    )


lg.hubs <- head(prob.hubs[order(prob.hubs[, "nrow"], decreasing = TRUE), ])
lg.hubs[, 1] <- airportid[airportid[, 1] %in% lg.hubs[, 1], 2]
lg.hubs[, 1] <- factor(lg.hubs[order(lg.hubs[, "meandep"], decreasing = TRUE), 1], labels = c("DEN", "LAX", "ATL", "ORD", "PHX", "DFW"), ordered = TRUE)
names(lg.hubs) <- c("ORIGIN_AIRPORT_ID", "Mean Delay", "Median Delay", "Flights")
qplot(data = melt(lg.hubs)[1:12,], x = ORIGIN_AIRPORT_ID, y = value, fill = variable, geom = "bar", position = "dodge") +
  scale_x_discrete(name ='') + scale_y_continuous(name = "Minutes") + opts(title = expression("Delays at Busiest Airports in January 2011"))




hrFactor <- function(input) {
  hr.seq <- formatC(seq(0, 2400, 100), width = 4, format = "d", flag = "0")
  hr.breaks <- paste(hr.seq[-length(hr.seq)], "to", hr.seq[-1], sep = " ")
  cut(input, breaks = seq(0, 2400, 100), labels = hr.breaks, include.lowest = TRUE, right = FALSE)
}

hr.del <- data.frame(ontime[, c("DEP_DELAY", "DEP_TIME", "ARR_DELAY", "ARR_TIME")])
hr.del[, "DEP_TIME"] <- hrFactor(hr.del[, "DEP_TIME"])
hr.del[, "ARR_TIME"] <- hrFactor(hr.del[, "ARR_TIME"])


formatC(seq(0, 2400, 100), width = 4, format = "d", flag = "0")




