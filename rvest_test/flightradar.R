library (rvest)
library (magrittr)
library (rjson)

uri <- "https://www.flightradar24.com/data/airports/bos/routes"

scriptnodes <- read_html (uri) %>%
    html_nodes("script")

for (i in seq_along (scriptnodes))
{
    content <- scriptnodes %>% extract2 (i) %>% html_text
    if (grepl ("var arrRoutes=", content))
    {
        content <- gsub ("var arrRoutes=", "", content)
        routes <- fromJSON (content)
        break
    }
}

print (routes)
