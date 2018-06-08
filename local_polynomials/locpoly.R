library (KernSmooth)
library (magrittr)

data(geyser, package = "MASS")
# local linear density estimate
x <- geyser$duration
est <- locpoly(x, bandwidth = 0.25)
plot(est, type = "l")
est2 <- locpoly(x = seq_along (x), y = x, bandwidth = 0.25)
plot(est, type = "l", ylim = c(0,5))
lines(est$x, est2$y)
plot (x)
lines(est2$y, col = "red")
lines(x, col = "green")

# local linear regression estimate

y <- geyser$waiting

fit <- locpoly(x, y, bandwidth = 0.25)
plot(x, y, ylim = c (0,110))
lines(fit)

fit2 <- locpoly(x = seq_along(y), y, bandwidth = 0.25)
plot (fit2)
plot (fit2, type ="l")


dat <- read.csv2 ("~/R/stress_event_detection/mos.csv")
dat$scra_all %<>% as.character %>% as.numeric
xx <- dat$scra_all

gsr_fit <- locpoly(x = seq_along(xx), y = xx, bandwidth = 4)
plot (xx, type = "l")
lines (gsr_fit, col="red")
