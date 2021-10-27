library(sp)                    #spatial dataframe for R
library(rgdal)                 #working with spatial data
library(sf)
library(tmap)                  #thematic map
library(tmaptools)             #allows Shapefiles for R
library(RSQLite)
library(tidyverse)
library(janitor)               #clean_names
library(plotly)                #plotting
library(maptools)
library(classInt)              #class interval for mapping
library(RColorBrewer)          #helpw with mapping
library(rgeos)                 #working with spatial data
library(geojsonio)
library(OpenStreetMap)
library(raster)
library(fs)
library(rmapshaper)
library(ggplot2)

##printing out what's in the layers
st_layers(here::here("gadm36_AUS.gpkg"))

##importing layername = "gadm36_AUS_0"
Ausoutline <- st_read(here::here("gadm36_AUS.gpkg"), 
                      layer = 'gadm36_AUS_0')
#print(Ausoutline)
st_crs(Ausoutline)$proj4string
#st_set_crs(Ausoutline, 4326)

##transform to GDA94 (local CRS for Australia)
AusoutlinePROJECTED <- Ausoutline %>%
  st_transform(.,3112)
print(AusoutlinePROJECTED)




