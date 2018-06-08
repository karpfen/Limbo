library (rjson)
library (magrittr)

flights <- fromJSON (file = "flights2.json")
d <- rep ("", 30)
n_flights <- rep (0, 30)

for (i in seq_along (flights))
{
    d [i] <- flights %>% extract2 (i) %>% extract2 (1)
    n_flights [i] <- flights %>% extract2 (i) %>% extract2 (2)
}

d_p <- d %>% as.POSIXct
sum (n_flights)

plot (x = d_p, y = n_flights, type = "l")
