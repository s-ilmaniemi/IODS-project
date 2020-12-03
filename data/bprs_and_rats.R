# Sarianna Ilmaniemi, 25 Nov 2020 
# Data wrangling exercise 4
# Data source: https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data

library(dplyr); library(stringr); library(tidyr)

BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep=" ", header=TRUE)

RATS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", sep="\t", header=T)

#check the names of the variables
names(BPRS)
names(RATS)

#check how data sets look like
str(BPRS)
str(RATS)

summary(BPRS)
summary(RATS)

#categorial variables to factorsBPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)
BPRS$treatment <- factor(BPRS$treatment)

RATS$ID <- factor(RATS$ID)
RATS$Group <- factor(RATS$Group)

# from wide to long and check how data look like
BPRSL <-  BPRS %>% gather(key = weeks, value = bprs, -treatment, -subject) %>% mutate(week = as.integer(substr(BPRSL$weeks, 5, 5)))

str(BPRSL)

RATSL <- RATS %>% gather(key = WD, value = Weight, -ID, -Group) %>% mutate(Time = as.integer(substr(WD,3,4))) 

str(RATSL)

summary(BPRSL)
summary(RATSL)

#save data files
write.csv(BPRSL, file="data/BPRSL.csv", row.names=F)
testi<-read.csv("data/BPRSL.csv", header=T)

testi
str(testi)

write.csv(RATSL, file="data/RATSL.csv", row.names=F)
testi<-read.csv("data/RATSL.csv", header=T)

testi
str(testi)


