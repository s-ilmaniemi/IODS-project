# Sarianna Ilmaniemi, 3 Nov 2020 
# Data wrangling exercise
# Data source:  http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt 
# Data despcription: https://www.mv.helsinki.fi/home/kvehkala/JYTmooc/JYTOPKYS3-meta.txt

lrn14 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)

dim(lrn14)

# The data frame has 183 rows i.e. observations and 60 columns i.e. variables

str(lrn14)

# All other variables except the gender variable have numbers values (integers) and the gender variable has 
# character values

# Access the dplyr library
library(dplyr)

# questions related to deep, surface and strategic learning
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")

# select the columns related to deep learning and create column 'deep' by averaging
deep_columns <- select(lrn14, one_of(deep_questions))
lrn14$deep <- rowMeans(deep_columns)

library(GGally)
library(ggplot2)

# select the columns related to surface learning and create column 'surf' by averaging
surface_columns <- select(lrn14, one_of(surface_questions))
lrn14$surf <- rowMeans(surface_columns)

# select the columns related to strategic learning and create column 'stra' by averaging
strategic_columns <- select(lrn14, one_of(strategic_questions))
lrn14$stra <- rowMeans(strategic_columns)

keep_columns <- c("gender","Age","Attitude", "deep", "stra", "surf", "Points")

# select the 'keep_columns' to create a new dataset
learning2014 <- select(lrn14, one_of(keep_columns))

# see the stucture of the new dataset
str(learning2014)


# print out the column names of the data
colnames(learning2014)

# change the name of the second column
colnames(learning2014)[2] <- "age"

# change the name of the third column
colnames(learning2014)[3] <- "attitude"

# change the name of "Points" to "points"
colnames(learning2014)[7] <- "points"

# print out the new column names of the data

colnames(learning2014)

# select rows where points is greater than zero
learning2014 <- filter(learning2014, points > 0)

str(learning2014)

#setting working directory
setwd("~/R/IODS-project")
getwd()

#saving and reading data
?write.csv
?write.table
write.table(learning2014, file = "data/learning2014.txt")

lrn14 <- read.table("data/learning2014.txt")

str(lrn14)

head(lrn14)


