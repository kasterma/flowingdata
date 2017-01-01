library(testthat)

education <- read.csv("downloads/2009education.csv")
high.order <- order(education$high)
education.high <- education[high.order,]

############################
summary(education)
str(education)

library(data.table)

ed_dt <- as.data.table(education)
ed_dt.high <- ed_dt[order(high)]

expect_true(all.equal(education.high, ed_dt.high, check.attributes = FALSE))

##

library(dplyr)
ed_dp <- education
ed_dp.high <- ed_dp %>% arrange(high)

expect_true(all.equal(education.high, ed_dp.high, check.attributes = FALSE))
## row names are not ordered with the rows
expect_equal(row.names(education.high), as.character(seq(from = 51, to = 1, by = -1)))

glimpse(education)
############################

plot(education$high)
plot(education.high$high)

with(education, plot(high, bs))

plot(education[,])

###########################
library(ggplot2)

ggplot(education, aes(x = high, y = bs)) + geom_point()

library(GGally)
ggpairs(education[,2:4])

###########################

plot(education.high$high)
plot(education.high$high, type = "l")
plot(education.high$high, type = "h")  # high density chart (bar chart with skinny bars)
plot(education.high$high, type = "s")  # step

plot(education.high$high,
     las = 1,  # labels y-axis horizontal
     xlab = "XXX",
     ylab = "YYY",
     main = "Plot title")

barplot(education$high)

boxplot(education$high)
boxplot(education[, 2:4])

###########################
gp <- ggplot(education.high, aes(1:nrow(education), high))
gp + geom_line()
gp + geom_line() + ylim(c(0, 100))
gp + geom_point()
gp + geom_col(width = 0.1)
gp + coord_cartesian(ylim = c(75, 100)) + geom_col(width = 0.1) 

gp + geom_col()  # corresponds to barplot
gp + geom_col() + coord_flip()

ggplot(education.high, aes("x", high)) + geom_boxplot()
ggplot(education.high, aes("x", high)) + geom_boxplot()

library(tidyr)

xx <- education.high %>% gather(type, value, 2:4)
ggplot(xx, aes(type, value)) + geom_boxplot()

par(mfrow=c(2,3), mar=c(2,5,2,1), las=1, bty="n")
# then run some plots
# mfrow = 2 rows, 3 columns
# mar = margin
# other plotting options that are passed to all future plots (e.g. las = 1, all
#  labels on y-axes horizontal)