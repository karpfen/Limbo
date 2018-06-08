library (RPostgreSQL)

drv <-  DBI::dbDriver("PostgreSQL")
con <- dbConnect (drv, user = "postgres", password = "postgres",
                  host = "localhost")

years <- 2006:2018
sink ("log.txt")
for (i in seq_along (years))
{
    yr <- years [i]
    now <- Sys.time ()


    qry <- paste0 ("SELECT date FROM twitter_db WHERE date >= '", yr,
                   "-01-01'::Date AND date < '", yr + 1, "-01-01'::Date")

    dates <- dbGetQuery (con, qry)
    n_dates <- length (dates$date)

    logentry <- paste0 (now, " - year ", yr, " - n: ", n_dates, "\n")
    cat (logentry)

    if (n_dates > 0)
    {
        title_w <- paste0 ("Histogram of Twitter data from ", yr,
                           " (weekly bins); n = ", n_dates)
        title_m <- paste0 ("Histogram of Twitter data from ", yr,
                           " (monthly bins); n = ", n_dates)
        file_w <- paste0 ("twitter_histogram_", yr, "_weekly.png")
        file_m <- paste0 ("twitter_histogram_", yr, "_monthly.png")

        png (file_w, res = 100, width = 4000, height = 2000)
        hist (dates$date, "weeks", format = "%Y-%m", main = title_w)
        dev.off ()
        png (file_m, res = 100, width = 4000, height = 2000)
        hist (dates$date, "months", format = "%Y-%m", main = title_m)
        dev.off ()
    }
}

sink ()
dbDisconnect (con)
