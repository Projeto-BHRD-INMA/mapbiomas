########################################################
### SCRIPT TO JOIN TABLES                           ####
### Por: Danielle de O. Moreira                     ####
### Data: 03/04/2020                                ####
########################################################

#Combining the new tables in .csv
area.2018 <- read.csv("./output/area-uso-2018.csv")
area.2017 <- read.csv("./output/area-uso-2017.csv")
area.2016 <- read.csv("./output/area-uso-2016.csv")

list(area.2018, area.2017, area.2016)

area.2018
area.2017
area.2016

area <- merge(x = area.2018,
              y = area.2017,
              by = "classe")
area

full_join(area.2018, area.2017, by = c("id","classe"))

library(purrr)
list(area.2018, area.2017, area.2016)

# Use reduce to join together the contents of the list
reduce(left_join, by = c("id", "classe"))

library(abind)
area.uso.2016_2018 = abind(area.uso.2018, area.uso.2017, area.uso.2016, along = 2)
dimnames(area.uso.2016_2018)[[3]] = c("Score","Sample Size")
area.uso.2016_2018
