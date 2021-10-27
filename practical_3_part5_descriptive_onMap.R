##Visualising data on Map

#load the rmapshaper package
library(rmapshaper)

##Plotting on Australia map
#plot(Ausoutline$geom) #too heavy - do not run!

#simplify the shapefile (keep specifies the % of points to keep
AusoutSIMPLE<-Ausoutline %>%
  ms_simplify(.,keep=0.05)
plot(AusoutSIMPLE$geom)

#Making sure both layers are in the same CRS system
print(AusoutSIMPLE)
crs(worldclimtemp)

##Combining both layers
#Always crop -> mask for large data
Austemp <- worldclimtemp %>%
  #now crop our temp data to the extent (square that can fit the shapefile)
  crop(.,Ausoutline) #argument: raster object first
#plot the output
plot(Austemp)
#Making adjustments - 'masking', just picking up the data on the needed shape
exactAus <- Austemp %>%
  mask(.,Ausoutline, na.rm=TRUE)
plot(exactAus)

####################
##Plotting histogram
#subset using the known location of the raster
#hist(exactAus[[3]], col="red", main ="March temperature")
#OR
#subset with the word Mar
hist(raster::subset(exactAus, "Mar"), col="red", main ="March temperature")

##Histogram with ggplot - creating a data frame first
library(ggplot2) #all information is formatted with +
exactAusdf <- exactAus %>%
  as.data.frame()

# set up the basic histogram
gghist <- ggplot(exactAusdf,    #cerates a blank plot page 
                 aes(x=Mar)) +  # ->loading March data
  geom_histogram(color="black", #creating geometry = histogram this time
                 fill="white")+ 
  labs(title="Ggplot2 histogram of Australian March temperatures", #labels
       x="Temperature", 
       y="Frequency")

# add a vertical line to the hisogram showing mean tempearture
gghist + geom_vline(aes(xintercept=mean(Mar, 
                                        na.rm=TRUE)),
                    color="blue", 
                    linetype="dashed", 
                    size=1)+
  theme(plot.title = element_text(hjust = 0.5)) #adjsuting the position of the title to center