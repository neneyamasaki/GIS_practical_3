library(raster)

##loading the raster data
jan<-raster(here::here("wc2.1_5m_tmax_01.tif"))

##checking the details - CRS: WGS84
# jan
# plot(jan)

##convert CRS using projectRaster() with PROJ4 string to Mollweide (ESPG: 4326)
##could use epsg code only (latter option)
newproj<-"+proj=moll +lon_0=0 +x_0=0 +y_0=0 +ellps=WGS84 +datum=WGS84 +units=m +no_defs"
#newproj2 <- "+init=epsg:4326"

# get the jan raster and give it the new proj4
pr1 <- jan %>%
  projectRaster(., crs=newproj)
#plot(pr1)


