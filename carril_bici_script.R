list_of_packages <- c("rgdal", "leaflet", "raster", "sp")

new.packages <- list_of_packages[!(list_of_packages %in%
                                     installed.packages()[,"Package"])]

if(length(new.packages)){
  install.packages(new.packages, repos='http://cran.us.r-project.org')
  lapply(list_of_packages,function(x){library(x,character.only=TRUE)}) 
}

library(rgdal)
library(leaflet)


## Downloading data
url = "http://opendata-ajuntament.barcelona.cat/resources/bcn/CARRIL_BICI.DBF"
download.file(url, destfile = "carril_bici.dbf", method = "auto")

url = "http://opendata-ajuntament.barcelona.cat/resources/bcn/CARRIL_BICI.prj"
download.file(url, destfile = "carril_bici.prj", method = "auto")

url = "http://opendata-ajuntament.barcelona.cat/resources/bcn/CARRIL_BICI.SHP"
download.file(url, destfile = "carril_bici.shp", method = "auto")

url = "http://opendata-ajuntament.barcelona.cat/resources/bcn/CARRIL_BICI.SHX"
download.file(url, destfile = "carril_bici.shx", method = "auto")

## Loading data
# ogrInfo("carril_bici") # Gives information about the Shapefile
carril_bici <- readOGR("carril_bici")
proj_carril_bici <- sp::spTransform(carril_bici, CRS("+init=epsg:4326"))

## Plotting with leaflet
m <- leaflet() %>% addTiles()
m %>% setView(lng = 2.154007, lat = 41.390205, zoom = 10) # set centre and extent of map
m %>% addPolylines(data = proj_carril_bici, color = "blue", weight = 1)

carril_bici 
