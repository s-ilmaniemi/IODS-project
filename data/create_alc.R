# Sarianna Ilmaniemi, 11 Nov 2020 
# Data wrangling exercise 3
# Data source: https://archive.ics.uci.edu/ml/datasets/Student+Performance 

por <- read.csv(file= "data/student-por.csv", sep = ";", header=T)
por

math <- read.csv(file= "data/student-mat.csv", sep = ";", header=T)
math

#Exploring the structure and dimensions of the data
dim(por)
str(por)
#Por: 649 observations and 33 variables
dim(math)
str(math)
#Mat: 395 observations and 33 variables

#The joining of the datasets with the code provided by Reijo Sund

# Define own id for both datasets
library(dplyr)
por_id <- por %>% mutate(id=1000+row_number()) 
math_id <- math %>% mutate(id=2000+row_number())

# Which columns vary in datasets
free_cols <- c("id","failures","paid","absences","G1","G2","G3")

# The rest of the columns are common identifiers used for joining the datasets
join_cols <- setdiff(colnames(por_id),free_cols)

join_cols
free_cols

pormath_free <- por_id %>% bind_rows(math_id) %>% select(one_of(free_cols))

# Combine datasets to one long data
#   NOTE! There are NO 382 but 370 students that belong to both datasets
#         Original joining/merging example is erroneous!
pormath <- por_id %>% 
  bind_rows(math_id) %>%
  # Aggregate data (more joining variables than in the example)  
  group_by(.dots=join_cols) %>%  
  # Calculating required variables from two obs  
  summarise(                                                           
    n=n(),
    id.p=min(id),
    id.m=max(id),
    failures=round(mean(failures)),     #  Rounded mean for numerical
    paid=first(paid),                   #    and first for chars
    absences=round(mean(absences)),
    G1=round(mean(G1)),
    G2=round(mean(G2)),
    G3=round(mean(G3))    
  ) %>%
  # Remove lines that do not have exactly one obs from both datasets
  #   There must be exactly 2 observations found in order to joining be succesful
  #   In addition, 2 obs to be joined must be 1 from por and 1 from math
  #     (id:s differ more than max within one dataset (649 here))
  filter(n==2, id.m-id.p>650) %>%  
  # Join original free fields, because rounded means or first values may not be relevant
  inner_join(pormath_free,by=c("id.p"="id"),suffix=c("",".p")) %>%
  inner_join(pormath_free,by=c("id.m"="id"),suffix=c("",".m")) %>%
  # Calculate other required variables  
  ungroup %>% mutate(
    alc_use = (Dalc + Walc) / 2,
    high_use = alc_use > 2,
    cid=3000+row_number()
  )

# Save created data to folder 'data' as an Excel worksheet
library(openxlsx)
write.xlsx(pormath,file="data/pormath.xlsx")

str(pormath)

#Create a dataset that only contains 35 variables, dropping the variables from the original datasets (suffix .p or .m) and id variables
pormat<-subset(pormath, select= c(join_cols, "failures","paid","absences","G1","G2","G3", "alc_use", "high_use" ))

str(pormat)
#Save as .csv files and check that the file opens correctly
write.csv(pormat, file="data/pormat.csv", row.names=F)
testi<-read.csv("data/pormat.csv", header=T)

testi
str(testi)

