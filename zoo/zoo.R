library (zoo)

t1 <- runif (100)
t2 <- rollmean (t1, k = 20, fill = NA)
t3 <- na.fill (t2, "extend")
t4 <- na.approx (t2, na.rm = FALSE)
t5 <- na.spline (t2)
