# Sarianna Ilmaniemi, 19 Nov 2020 
# Data wrangling exercise 4
# Data source:http://hdr.undp.org/en/content/human-development-index-hdi


hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)

gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

#Dimensions and structures of the data sets

dim(hd)
str(hd)

#hd has 195 observations and 8 variables

dim(gii)
str(gii)

#gii has 195 observations and 10 variables

#Summaries of variables

summary(hd)
summary(gii)

#Rename variables

names(hd)<-c("rhdi","country","hdi","lexp","ey_edu","my_edu","gni","diffrank")
str(hd)

names(gii)<-c("rgii","country","gii","matmor","adobr","preparl","edu2F","edu2M","labF","labM")
str(gii)

#Create two new ratio variables in gii

library(dplyr)

gii <- mutate(gii, ratioedu = edu2F/edu2M)
gii <- mutate(gii, ratiolab = labF/labM)

str(gii)

#Join data sets

human <- inner_join(hd, gii, by = "country")

#Check number of observations (should be 195) and variables (should be 19)
str(human)

#Save as .csv files and check that the file opens correctly
write.csv(human, file="data/human.csv", row.names=F)
testi<-read.csv("data/human.csv", header=T)

testi
str(testi)



