library (parallel)

# fill with dummy data
tables <- vector ("list", 100000)
create_df <- function (x) { cars }
tables <- lapply (tables, create_df)


alter_df <- function (i)
{
  x <- tables [[i]]
  x$indexnumber <- i
  x
}

tables <- mclapply (seq_along (tables), alter_df)