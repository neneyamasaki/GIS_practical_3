# look in our folder, find the files that end with .tif and 
library(fs)
#dir_info(here::here()) 

#select data ending with.tif
listfiles<-dir_info(here::here()) %>%
  filter(str_detect(path, ".tif$")) %>%  #$: ending with that string
  pull(path) #extracting columns
#have a look at the file names 
#listfiles

#reading all the files ending with .tif
worldclimtemp <- listfiles %>%
  stack()
#have a look at the raster stack
worldclimtemp
#access the january layer
worldclimtemp[[1]]

##naming each layer appropriately 
#creating month list
month <- c("Jan", "Feb", "Mar", "Apr", "May", "Jun", 
           "Jul", "Aug", "Sep", "Oct", "Nov", "Dec")
#names function to assign names
names(worldclimtemp) <- month
#worldclimtemp$Jan

########
##making a dataframe
#creating lists
site <- c("Brisbane", "Melbourne", "Perth", "Sydney", "Broome", "Darwin", "Orange", 
          "Bunbury", "Cairns", "Adelaide", "Gold Coast", "Canberra", "Newcastle", 
          "Wollongong", "Logan City" )
lon <- c(153.03, 144.96, 115.86, 151.21, 122.23, 130.84, 149.10, 115.64, 145.77, 
         138.6, 153.43, 149.13, 151.78, 150.89, 153.12)
lat <- c(-27.47, -37.91, -31.95, -33.87, 17.96, -12.46, -33.28, -33.33, -16.92, 
         -34.93, -28, -35.28, -32.93, -34.42, -27.64)
#Put all of this information into one list 
samples <- data.frame(site, lon, lat, row.names="site")
samples
# Extract the data from the Rasterstack for all points 
AUcitytemp<- raster::extract(worldclimtemp, samples)
AUcitytemp

##adding city names to the row of AUcitytemp
Aucitytemp2 <- AUcitytemp %>% 
  as_tibble()%>% 
  add_column(Site = site, .before = "Jan") #mutate may not allow specification of column
Aucitytemp2
