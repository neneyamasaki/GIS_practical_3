## Multiple data visualisation

#Creating a tidy data by pivot-longer()
squishdata<-exactAusdf%>%
  pivot_longer(
    cols = 1:12,
    names_to = "Month",
    values_to = "Temp"
  )

##two layers
#extracting data for January or June in the "Month" column
twomonths <- squishdata %>%
  filter(., Month=="Jan" | Month=="Jun")
#Taking average for Jan and Jun
meantwomonths <- twomonths %>%
  group_by(Month) %>%
  summarise(mean=mean(Temp, na.rm=TRUE))
#meantwomonths
#ploting histogram
ggplot(twomonths, aes(x=Temp, color=Month, fill=Month)) + #loadingdata
  geom_histogram(position="identity", alpha=0.5)+  #specifying geometry
  geom_vline(data=meantwomonths,   #vertical line
             aes(xintercept=mean, 
                 color=Month),     #matching histogram color
             linetype="dashed")+
  labs(title="Ggplot2 histogram of Australian Jan and Jun
       temperatures",
       x="Temperature",
       y="Frequency")+
  theme_classic()+   #histogram theme
  theme(plot.title = element_text(hjust = 0.5)) #cnentrality of the title


##Plot faceted histogram (more than 2 layers)
data_complete_cases <- squishdata %>%
  #Getting rid of NAs
  drop_na()%>% 
  #levels specifying the order
  mutate(Month = factor(Month, levels = c("Jan","Feb","Mar", 
                                          "Apr","May","Jun",
                                          "Jul","Aug","Sep",
                                          "Oct","Nov","Dec")))
#plotting
ggplot(data_complete_cases, aes(x=Temp, na.rm=TRUE))+
  geom_histogram(color="black", binwidth = 5)+
  labs(title="Ggplot2 faceted histogram of Australian temperatures", 
       x="Temperature",
       y="Frequency")+
  facet_grid(Month ~ .)+  #facet by month (~:modeled by) temperature
  theme(plot.title = element_text(hjust = 0.5))