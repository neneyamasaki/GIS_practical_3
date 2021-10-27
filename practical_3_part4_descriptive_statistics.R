library(rmapshaper)

##extracting Perth data
Perthtemp <- Aucitytemp2 %>%
  filter(site=="Perth")
#Perthtemp <- Aucitytemp2[3,] #alternative method

##Histogram 1
hist(as.numeric(Perthtemp)) #x must be numeric

##Histogram 2
#define where you want the breaks in the historgram
userbreak<-c(16,18,20,22,24,26,28,30,32)
hist(as.numeric(Perthtemp), 
     breaks=userbreak, 
     col="red", 
     main="Histogram of Perth Temperature", 
     xlab="Temperature", 
     ylab="Frequency")

##Checking Histogram
histinfo <- Perthtemp %>%
  as.numeric()%>%  #hist comes from R, and it expects numeric values (not double)
  hist(.)
histinfo