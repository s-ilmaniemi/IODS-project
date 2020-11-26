# Sarianna Ilmaniemi, 25 Nov 2020 
# Data wrangling exercise 4
# Data source:http://hdr.undp.org/en/content/human-development-index-hdi

library(dplyr); library(stringr)
human<-read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human1.txt", sep=",", header=TRUE)

#Description of data
#This data set contains several different indicators e.g. gross capital per capita, life expectancy, education levels etc. 
#from different countries and larger areas.

#check that you have 195 obs. and 19 variables
str(human)

#Mutate GNI to numeric form
human<-human %>% mutate(GNI=str_replace(human$GNI, pattern=",", replace ="")%>%as.numeric())

str(human)

# select the variables to keep
keep<- c("Country", "Edu2.FM", "Labo.FM", "Edu.Exp", "Life.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F")
human <- select(human, one_of(keep))

# filter out all rows with NA values
human<- human %>% mutate(comp = complete.cases(human))
human <- filter(human, comp=="TRUE")

str(human)
data.frame(human)
tail(human, 60)

#remove last 7 rows that are areas instead of countries
last <- nrow(human) - 7
human <- human[1:last,]

# name rows with country names
rownames(human) <- human_$Country
# remove country and comp variable
human<-human[,2:9]
#check that you have 155 obs. and 8 variables
str(human)


#Save as .csv files and check that the file opens correctly
write.csv(human, file="data/human.csv", row.names=T)
testi<-read.csv("data/human.csv", header=T, sep=",", row.names=1)

data.frame(testi)
str(testi)

