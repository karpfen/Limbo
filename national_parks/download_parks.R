q0 <- opq("Europe")
q1 <- add_osm_feature(q0, key = 'name', value = "Thames", value_exact = FALSE)
x <- osmdata_sf(q1)
x
library (osmdata)
library (magrittr)
library (sf)

output_file <- "california.gpkg"

osm <- osmdata::getbb ("State of California", format_out = "polygon") %>% extract2 (1)
wkt <- paste0 ("SRID=4326;POLYGON((",
               paste (paste (osm[, 1], osm [, 2]), collapse = ","),
               "))")
outline <- st_as_sfc (wkt)

st_write (outline, output_file)
