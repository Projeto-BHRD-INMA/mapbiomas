####################################################################
###         CALCULATE LAND COVER USE AREA FOR EACH SUBWATERSHED
###
### By: Danielle de Oliveira Moreira
### date: 14/07/2020    updated:14/03/2022
####################################################################


library(raster)
library(rgdal) #carregar shp

####Loading several rasters - mapbiomas 2019

uso_1985_bhrd <- raster("./data/mapbiomas-col6-bhrd/raster/1985/coverage-1985.tif")

uso_2020_bhrd <- raster("./data/mapbiomas-col6-bhrd/raster/2020/coverage-2020.tif")

data_uph_1985 <- list.files("./data/mapbiomas-col6-bhrd/raster/1985/uph", pattern = "coverage", full.names = T)

data_uph_2020 <- list.files("./data/mapbiomas-col6-bhrd/raster/2020/uph", pattern = "coverage", full.names = T)

data_uph_1985
data_uph_2020

#loading uph (subwatershed)
uso_caratinga_1985 <- raster(data_uph_1985[1])
uso_guandu_1985 <- raster(data_uph_1985[2])
uso_manhuacu_1985 <- raster(data_uph_1985[3])
uso_piracicaba_1985 <- raster(data_uph_1985[4])
uso_piranga_1985 <- raster(data_uph_1985[5])
uso_santonio_1985 <- raster(data_uph_1985[6])
uso_sjose_1985 <- raster(data_uph_1985[7])
uso_smaria_1985 <- raster(data_uph_1985[8])
uso_suacui_1985 <- raster(data_uph_1985[9])
uso_caratinga_2020 <- raster(data_uph_2020[1])
uso_guandu_2020 <- raster(data_uph_2020[2])
uso_manhuacu_2020 <- raster(data_uph_2020[3])
uso_piracicaba_2020 <- raster(data_uph_2020[4])
uso_piranga_2020 <- raster(data_uph_2020[5])
uso_santonio_2020 <- raster(data_uph_2020[6])
uso_sjose_2020 <- raster(data_uph_2020[7])
uso_smaria_2020 <- raster(data_uph_2020[8])
uso_suacui_2020 <- raster(data_uph_2020[9])



#Calculating the area of a cell --------------------------------------------------

##First, identify the name (in "names" of "uso" object) of the column to group_by.

##Now calculate the area for BHRD in 1985
library(dplyr)
area_uso_1985_bhrd <- as.data.frame(uso_1985_bhrd) %>%
    group_by(coverage.1985) %>%
    tally() %>%
    mutate(area_ha = n * 0.09) #multiplying by 0.09ha or 900m2, area of each cell.

area_uso_1985_bhrd

##For BHRD in 2020
area_uso_2020_bhrd <- as.data.frame(uso_2020_bhrd) %>%
    group_by(coverage.2020) %>%
    tally() %>%
    mutate(area_ha = n * 0.09) #multiplying by 0.09ha or 900m2, area of each cell.

area_uso_2020_bhrd

#For UPH Caratinga 1985
area_uso_caratinga_1985 <- as.data.frame(uso_caratinga_1985) %>%
    group_by(coverage.1985_Caratinga) %>%
    tally() %>%
    mutate(area_ha = n * 0.09) #multiplying by 0.09ha or 900m2, area of each cell.

area_uso_caratinga_1985

#For UPH Guandu 1985
area_uso_guandu_1985 <- as.data.frame(uso_guandu_1985) %>%
    group_by(coverage.1985_Guandu) %>%
    tally() %>%
    mutate(area_ha = n * 0.09) #multiplying by 0.09ha or 900m2, area of each cell.

area_uso_guandu_1985

#For UPH Manhuacu 1985
area_uso_manhuacu_1985 <- as.data.frame(uso_manhuacu_1985) %>%
    group_by(coverage.1985_Manhuacu) %>%
    tally() %>%
    mutate(area_ha = n * 0.09) #multiplying by 0.09ha or 900m2, area of each cell.

area_uso_manhuacu_1985

#For UPH Piracicaba 1985
area_uso_piracicaba_1985 <- as.data.frame(uso_piracicaba_1985) %>%
    group_by(coverage.1985_Piracicaba) %>%
    tally() %>%
    mutate(area_ha = n * 0.09) #multiplying by 0.09ha or 900m2, area of each cell.

area_uso_piracicaba_1985

#For UPH Piranga 1985
area_uso_piranga_1985 <- as.data.frame(uso_piranga_1985) %>%
    group_by(coverage.1985_Piranga) %>%
    tally() %>%
    mutate(area_ha = n * 0.09) #multiplying by 0.09ha or 900m2, area of each cell.

area_uso_piranga_1985

#For UPH Santo Antonio 1985
area_uso_santonio_1985 <- as.data.frame(uso_santonio_1985) %>%
    group_by(coverage.1985_SAntonio) %>%
    tally() %>%
    mutate(area_ha = n * 0.09) #multiplying by 0.09ha or 900m2, area of each cell.

area_uso_santonio_1985

#For UPH Sao Jose 1985
area_uso_sjose_1985 <- as.data.frame(uso_sjose_1985) %>%
    group_by(coverage.1985_Sjose) %>%
    tally() %>%
    mutate(area_ha = n * 0.09) #multiplying by 0.09ha or 900m2, area of each cell.

area_uso_sjose_1985

#For UPH Santa Maria 1985
area_uso_smaria_1985 <- as.data.frame(uso_smaria_1985) %>%
    group_by(coverage.1985_SMariaDoDoce) %>%
    tally() %>%
    mutate(area_ha = n * 0.09) #multiplying by 0.09ha or 900m2, area of each cell.

area_uso_smaria_1985

#For UPH Suacui 1985
area_uso_suacui_1985 <- as.data.frame(uso_suacui_1985) %>%
    group_by(coverage.1985_SuacuiGrande) %>%
    tally() %>%
    mutate(area_ha = n * 0.09) #multiplying by 0.09ha or 900m2, area of each cell.

area_uso_suacui_1985



#For UPH Caratinga 2020
area_uso_caratinga_2020 <- as.data.frame(uso_caratinga_2020) %>%
    group_by(coverage.2020_Caratinga) %>%
    tally() %>%
    mutate(area_ha = n * 0.09) #multiplying by 0.09ha or 900m2, area of each cell.

area_uso_caratinga_2020

#For UPH Guandu 2020
area_uso_guandu_2020 <- as.data.frame(uso_guandu_2020) %>%
    group_by(coverage.2020_Guandu) %>%
    tally() %>%
    mutate(area_ha = n * 0.09) #multiplying by 0.09ha or 900m2, area of each cell.

area_uso_guandu_2020

#For UPH Manhuacu 2020
area_uso_manhuacu_2020 <- as.data.frame(uso_manhuacu_2020) %>%
    group_by(coverage.2020_Manhuacu) %>%
    tally() %>%
    mutate(area_ha = n * 0.09) #multiplying by 0.09ha or 900m2, area of each cell.

area_uso_manhuacu_2020

#For UPH Piracicaba 2020
area_uso_piracicaba_2020 <- as.data.frame(uso_piracicaba_2020) %>%
    group_by(coverage.2020_Piracicaba) %>%
    tally() %>%
    mutate(area_ha = n * 0.09) #multiplying by 0.09ha or 900m2, area of each cell.

area_uso_piracicaba_2020

#For UPH Piranga 2020
area_uso_piranga_2020 <- as.data.frame(uso_piranga_2020) %>%
    group_by(coverage.2020_Piranga) %>%
    tally() %>%
    mutate(area_ha = n * 0.09) #multiplying by 0.09ha or 900m2, area of each cell.

area_uso_piranga_2020

#For UPH Santo Antonio 2020
area_uso_santonio_2020 <- as.data.frame(uso_santonio_2020) %>%
    group_by(coverage.2020_SAntonio) %>%
    tally() %>%
    mutate(area_ha = n * 0.09) #multiplying by 0.09ha or 900m2, area of each cell.

area_uso_santonio_2020

#For UPH Sao Jose 2020
area_uso_sjose_2020 <- as.data.frame(uso_sjose_2020) %>%
    group_by(coverage.2020_SJose) %>%
    tally() %>%
    mutate(area_ha = n * 0.09) #multiplying by 0.09ha or 900m2, area of each cell.

area_uso_sjose_2020

#For UPH Santa Maria 2020
area_uso_smaria_2020 <- as.data.frame(uso_smaria_2020) %>%
    group_by(coverage.2020_SMariaDoDoce) %>%
    tally() %>%
    mutate(area_ha = n * 0.09) #multiplying by 0.09ha or 900m2, area of each cell.

area_uso_smaria_2020

#For UPH Suacui 2020
area_uso_suacui_2020 <- as.data.frame(uso_suacui_2020) %>%
    group_by(coverage.2020_SuacuiGrande) %>%
    tally() %>%
    mutate(area_ha = n * 0.09) #multiplying by 0.09ha or 900m2, area of each cell.

area_uso_suacui_2020


#------------------ Save the results in txt ---------------------------------------
#For BHRD
write.csv(area_uso_1985_bhrd,"./results/mapbiomas-col6/raw/area-uso-1985_bhrd.csv",
          row.names = TRUE)

write.csv(area_uso_2020_bhrd,"./results/mapbiomas-col6/raw/area-uso-2020_bhrd.csv",
          row.names = TRUE)

#For Caratinga
write.csv(area_uso_caratinga_1985,
          "./results/mapbiomas-col6/raw/area-uso-1985_Caratinga.csv",
          row.names = TRUE)

write.csv(area_uso_caratinga_2020,
          "./results/mapbiomas-col6/raw/area-uso-2020_Caratinga.csv",
          row.names = TRUE)

#For Guandu
write.csv(area_uso_guandu_1985,
          "./results/mapbiomas-col6/raw/area-uso-1985_Guandu.csv",
          row.names = TRUE)

write.csv(area_uso_guandu_2020,
          "./results/mapbiomas-col6/raw/area-uso-2020_Guandu.csv",
          row.names = TRUE)

#For Manhuaçu
write.csv(area_uso_manhuacu_1985,
          "./results/mapbiomas-col6/raw/area-uso-1985_Manhuacu.csv",
          row.names = TRUE)

write.csv(area_uso_manhuacu_2020,
          "./results/mapbiomas-col6/raw/area-uso-2020_Manhuacu.csv",
          row.names = TRUE)

#For Piracicaba
write.csv(area_uso_piracicaba_1985,
          "./results/mapbiomas-col6/raw/area-uso-1985_Piracicaba.csv",
          row.names = TRUE)

write.csv(area_uso_piracicaba_2020,
          "./results/mapbiomas-col6/raw/area-uso-2020_Piracicaba.csv",
          row.names = TRUE)

#For Piranga
write.csv(area_uso_piranga_1985,
          "./results/mapbiomas-col6/raw/area-uso-1985_Piranga.csv",
          row.names = TRUE)

write.csv(area_uso_piranga_2020,
          "./results/mapbiomas-col6/raw/area-uso-2020_Piranga.csv",
          row.names = TRUE)

#For Santo Antônio
write.csv(area_uso_santonio_1985,
          "./results/mapbiomas-col6/raw/area-uso-1985_SAntonio.csv",
          row.names = TRUE)

write.csv(area_uso_santonio_2020,
          "./results/mapbiomas-col6/raw/area-uso-2020_SAntonio.csv",
          row.names = TRUE)

#For São José
write.csv(area_uso_sjose_1985,
          "./results/mapbiomas-col6/raw/area-uso-1985_SJose.csv",
          row.names = TRUE)

write.csv(area_uso_sjose_2020,
          "./results/mapbiomas-col6/raw/area-uso-2020_SJose.csv",
          row.names = TRUE)

#For Santa Maria
write.csv(area_uso_smaria_1985,
          "./results/mapbiomas-col6/raw/area-uso-1985_SMaria.csv",
          row.names = TRUE)

write.csv(area_uso_smaria_2020,
          "./results/mapbiomas-col6/raw/area-uso-2020_SMaria.csv",
          row.names = TRUE)

#For Suacui Grande
write.csv(area_uso_suacui_1985,
          "./results/mapbiomas-col6/raw/area-uso-1985_Suacui.csv",
          row.names = TRUE)

write.csv(area_uso_suacui_2020,
          "./results/mapbiomas-col6/raw/area-uso-2020_Suacui.csv",
          row.names = TRUE)


#----------------- MANIPULATING DATA -------------------#
# Manipulating table.
## Join tables to insert information of land cover use

#Opening table with land cover use codes
code <- read.csv2("./results/mapbiomas-col6/legend_col6_mapbiomas.csv", encoding="utf-8")

# Opening table with calculated areas
list_table_raw <- list.files("./results/mapbiomas-col6/raw",
                             pattern = ".csv", full.names = T)
list_table_raw


## Running each file from list_table_raw (line 312, changing line code for each subwatershed)
tab1 <- read.csv(list_table_raw[1], header = T, sep=",", dec=".", encoding="utf-8")
tab2 <- read.csv(list_table_raw[2], header = T, sep=",", dec=".", encoding="utf-8")
tab3 <- read.csv(list_table_raw[3], header = T, sep=",", dec=".", encoding="utf-8")
tab4 <- read.csv(list_table_raw[4], header = T, sep=",", dec=".", encoding="utf-8")
tab5 <- read.csv(list_table_raw[5], header = T, sep=",", dec=".", encoding="utf-8")
tab6 <- read.csv(list_table_raw[6], header = T, sep=",", dec=".", encoding="utf-8")
tab7 <- read.csv(list_table_raw[7], header = T, sep=",", dec=".", encoding="utf-8")
tab8 <- read.csv(list_table_raw[8], header = T, sep=",", dec=".", encoding="utf-8")
tab9 <- read.csv(list_table_raw[9], header = T, sep=",", dec=".", encoding="utf-8")
tab10 <- read.csv(list_table_raw[10], header = T, sep=",", dec=".", encoding="utf-8")
tab11 <- read.csv(list_table_raw[11], header = T, sep=",", dec=".", encoding="utf-8")
tab12 <- read.csv(list_table_raw[12], header = T, sep=",", dec=".", encoding="utf-8")
tab13 <- read.csv(list_table_raw[13], header = T, sep=",", dec=".", encoding="utf-8")
tab14 <- read.csv(list_table_raw[14], header = T, sep=",", dec=".", encoding="utf-8")
tab15 <- read.csv(list_table_raw[15], header = T, sep=",", dec=".", encoding="utf-8")
tab16 <- read.csv(list_table_raw[16], header = T, sep=",", dec=".", encoding="utf-8")
tab17 <- read.csv(list_table_raw[17], header = T, sep=",", dec=".", encoding="utf-8")
tab18 <- read.csv(list_table_raw[18], header = T, sep=",", dec=".", encoding="utf-8")
tab19 <- read.csv(list_table_raw[19], header = T, sep=",", dec=".", encoding="utf-8")
tab20 <- read.csv(list_table_raw[20], header = T, sep=",", dec=".", encoding="utf-8")


#BHRD 1985----
#library(dplyr)
colnames(tab1)[2] <- "ID" #change name of column number 2
tab1.1 <- dplyr::inner_join(tab1,
                            code[, c("ID", "my_class2")],
                            by = "ID") #join tables, but only my_class2 column
tab1.2 <- subset(tab1.1, select = c(my_class2, area_ha))


##We want to sum areas with same classes (rows), AND add a new column to calculate percentage
#library(dplyr)
tab1985_bhrd <- tab1.2 %>%
    group_by(my_class2) %>%
    summarise(area_ha = sum(area_ha)) %>%
    mutate(Percentage = paste0(round(area_ha/sum(area_ha)*100,2)))


#Caratinga 1985----
#library(dplyr)
colnames(tab2)[2] <- "ID" #change name of column number 2
tab2.1 <- dplyr::inner_join(tab2,
                            code[, c("ID", "my_class2")],
                            by = "ID") #join tables, but only my_class2 column
tab2.2 <- subset(tab2.1, select = c(my_class2, area_ha))


##We want to sum areas with same classes (rows), AND add a new column to calculate percentage
#library(dplyr)
tab1985_Caratinga <- tab2.2 %>%
    group_by(my_class2) %>%
    summarise(area_ha = sum(area_ha)) %>%
    mutate(Percentage = paste0(round(area_ha/sum(area_ha)*100,2)))


#Guandu 1985----
#library(dplyr)
colnames(tab3)[2] <- "ID" #change name of column number 2
tab3.1 <- dplyr::inner_join(tab3,
                            code[, c("ID", "my_class2")],
                            by = "ID") #join tables, but only my_class2 column
tab3.2 <- subset(tab3.1, select = c(my_class2, area_ha))


##We want to sum areas with same classes (rows), AND add a new column to calculate percentage
#library(dplyr)
tab1985_Guandu <- tab3.2 %>%
    group_by(my_class2) %>%
    summarise(area_ha = sum(area_ha)) %>%
    mutate(Percentage = paste0(round(area_ha/sum(area_ha)*100,2)))


#Manhuaçu 1985----
#library(dplyr)
colnames(tab4)[2] <- "ID" #change name of column number 2
tab4.1 <- dplyr::inner_join(tab4,
                            code[, c("ID", "my_class2")],
                            by = "ID") #join tables, but only my_class2 column
tab4.2 <- subset(tab4.1, select = c(my_class2, area_ha))


##We want to sum areas with same classes (rows), AND add a new column to calculate percentage
#library(dplyr)
tab1985_Manhuacu <- tab4.2 %>%
    group_by(my_class2) %>%
    summarise(area_ha = sum(area_ha)) %>%
    mutate(Percentage = paste0(round(area_ha/sum(area_ha)*100,2)))


#Piracicaba 1985----
#library(dplyr)
colnames(tab5)[2] <- "ID" #change name of column number 2
tab5.1 <- dplyr::inner_join(tab5,
                          code[, c("ID", "my_class2")],
                          by = "ID") #join tables, but only my_class2 column
tab5.2 <- subset(tab5.1, select = c(my_class2, area_ha))


##We want to sum areas with same classes (rows), AND add a new column to calculate percentage
#library(dplyr)
tab1985_Pira <- tab5.2 %>%
    group_by(my_class2) %>%
    summarise(area_ha = sum(area_ha)) %>%
    mutate(Percentage = paste0(round(area_ha/sum(area_ha)*100,2)))



#Piranga 1985----
#library(dplyr)
colnames(tab6)[2] <- "ID" #change name of column number 2
tab6.1 <- dplyr::inner_join(tab6,
                            code[, c("ID", "my_class2")],
                            by = "ID") #join tables, but only my_class2 column
tab6.2 <- subset(tab6.1, select = c(my_class2, area_ha))


##We want to sum areas with same classes (rows), AND add a new column to calculate percentage
#library(dplyr)
tab1985_Piranga <- tab6.2 %>%
    group_by(my_class2) %>%
    summarise(area_ha = sum(area_ha)) %>%
    mutate(Percentage = paste0(round(area_ha/sum(area_ha)*100,2)))


#Santo Antônio 1985----
#library(dplyr)
colnames(tab7)[2] <- "ID" #change name of column number 2
tab7.1 <- dplyr::inner_join(tab7,
                            code[, c("ID", "my_class2")],
                            by = "ID") #join tables, but only my_class2 column
tab7.2 <- subset(tab7.1, select = c(my_class2, area_ha))


##We want to sum areas with same classes (rows), AND add a new column to calculate percentage
#library(dplyr)
tab1985_SantoAntonio <- tab7.2 %>%
    group_by(my_class2) %>%
    summarise(area_ha = sum(area_ha)) %>%
    mutate(Percentage = paste0(round(area_ha/sum(area_ha)*100,2)))


#Sao José 1985----
#library(dplyr)
colnames(tab8)[2] <- "ID" #change name of column number 2
tab8.1 <- dplyr::inner_join(tab8,
                            code[, c("ID", "my_class2")],
                            by = "ID") #join tables, but only my_class2 column
tab8.2 <- subset(tab8.1, select = c(my_class2, area_ha))


##We want to sum areas with same classes (rows), AND add a new column to calculate percentage
#library(dplyr)
tab1985_SaoJose <- tab8.2 %>%
    group_by(my_class2) %>%
    summarise(area_ha = sum(area_ha)) %>%
    mutate(Percentage = paste0(round(area_ha/sum(area_ha)*100,2)))

#Santa Maria do Doce 1985----
#library(dplyr)
colnames(tab9)[2] <- "ID" #change name of column number 2
tab9.1 <- dplyr::inner_join(tab9,
                            code[, c("ID", "my_class2")],
                            by = "ID") #join tables, but only my_class2 column
tab9.2 <- subset(tab9.1, select = c(my_class2, area_ha))


##We want to sum areas with same classes (rows), AND add a new column to calculate percentage
#library(dplyr)
tab1985_SantaMariaDoDoce <- tab9.2 %>%
    group_by(my_class2) %>%
    summarise(area_ha = sum(area_ha)) %>%
    mutate(Percentage = paste0(round(area_ha/sum(area_ha)*100,2)))


#Suaçuí Grande 1985----
#library(dplyr)
colnames(tab10)[2] <- "ID" #change name of column number 2
tab10.1 <- dplyr::inner_join(tab10,
                            code[, c("ID", "my_class2")],
                            by = "ID") #join tables, but only my_class2 column
tab10.2 <- subset(tab10.1, select = c(my_class2, area_ha))


##We want to sum areas with same classes (rows), AND add a new column to calculate percentage
#library(dplyr)
tab1985_Suacui <- tab10.2 %>%
    group_by(my_class2) %>%
    summarise(area_ha = sum(area_ha)) %>%
    mutate(Percentage = paste0(round(area_ha/sum(area_ha)*100,2)))





#BHRD 2020----
#library(dplyr)
colnames(tab11)[2] <- "ID" #change name of column number 2
tab11.1 <- dplyr::inner_join(tab11,
                            code[, c("ID", "my_class2")],
                            by = "ID") #join tables, but only my_class2 column
tab11.2 <- subset(tab11.1, select = c(my_class2, area_ha))


##We want to sum areas with same classes (rows), AND add a new column to calculate percentage
#library(dplyr)
tab2020_bhrd <- tab11.2 %>%
    group_by(my_class2) %>%
    summarise(area_ha = sum(area_ha)) %>%
    mutate(Percentage = paste0(round(area_ha/sum(area_ha)*100,2)))


#Caratinga 2020----
#library(dplyr)
colnames(tab12)[2] <- "ID" #change name of column number 2
tab12.1 <- dplyr::inner_join(tab12,
                            code[, c("ID", "my_class2")],
                            by = "ID") #join tables, but only my_class2 column
tab12.2 <- subset(tab12.1, select = c(my_class2, area_ha))


##We want to sum areas with same classes (rows), AND add a new column to calculate percentage
#library(dplyr)
tab2020_Caratinga <- tab12.2 %>%
    group_by(my_class2) %>%
    summarise(area_ha = sum(area_ha)) %>%
    mutate(Percentage = paste0(round(area_ha/sum(area_ha)*100,2)))


#Guandu 2020----
#library(dplyr)
colnames(tab13)[2] <- "ID" #change name of column number 2
tab13.1 <- dplyr::inner_join(tab13,
                            code[, c("ID", "my_class2")],
                            by = "ID") #join tables, but only my_class2 column
tab13.2 <- subset(tab13.1, select = c(my_class2, area_ha))


##We want to sum areas with same classes (rows), AND add a new column to calculate percentage
#library(dplyr)
tab2020_Guandu <- tab13.2 %>%
    group_by(my_class2) %>%
    summarise(area_ha = sum(area_ha)) %>%
    mutate(Percentage = paste0(round(area_ha/sum(area_ha)*100,2)))


#Manhuaçu 2020----
#library(dplyr)
colnames(tab14)[2] <- "ID" #change name of column number 2
tab14.1 <- dplyr::inner_join(tab14,
                            code[, c("ID", "my_class2")],
                            by = "ID") #join tables, but only my_class2 column
tab14.2 <- subset(tab14.1, select = c(my_class2, area_ha))


##We want to sum areas with same classes (rows), AND add a new column to calculate percentage
#library(dplyr)
tab2020_Manhuacu <- tab14.2 %>%
    group_by(my_class2) %>%
    summarise(area_ha = sum(area_ha)) %>%
    mutate(Percentage = paste0(round(area_ha/sum(area_ha)*100,2)))


#Piracicaba 2020----
#library(dplyr)
colnames(tab15)[2] <- "ID" #change name of column number 2
tab15.1 <- dplyr::inner_join(tab15,
                            code[, c("ID", "my_class2")],
                            by = "ID") #join tables, but only my_class2 column
tab15.2 <- subset(tab15.1, select = c(my_class2, area_ha))


##We want to sum areas with same classes (rows), AND add a new column to calculate percentage
#library(dplyr)
tab2020_Pira <- tab15.2 %>%
    group_by(my_class2) %>%
    summarise(area_ha = sum(area_ha)) %>%
    mutate(Percentage = paste0(round(area_ha/sum(area_ha)*100,2)))



#Piranga 2020----
#library(dplyr)
colnames(tab16)[2] <- "ID" #change name of column number 2
tab16.1 <- dplyr::inner_join(tab16,
                            code[, c("ID", "my_class2")],
                            by = "ID") #join tables, but only my_class2 column
tab16.2 <- subset(tab16.1, select = c(my_class2, area_ha))


##We want to sum areas with same classes (rows), AND add a new column to calculate percentage
#library(dplyr)
tab2020_Piranga <- tab16.2 %>%
    group_by(my_class2) %>%
    summarise(area_ha = sum(area_ha)) %>%
    mutate(Percentage = paste0(round(area_ha/sum(area_ha)*100,2)))


#Santo Antônio 2020----
#library(dplyr)
colnames(tab17)[2] <- "ID" #change name of column number 2
tab17.1 <- dplyr::inner_join(tab17,
                            code[, c("ID", "my_class2")],
                            by = "ID") #join tables, but only my_class2 column
tab17.2 <- subset(tab17.1, select = c(my_class2, area_ha))


##We want to sum areas with same classes (rows), AND add a new column to calculate percentage
#library(dplyr)
tab2020_SantoAntonio <- tab17.2 %>%
    group_by(my_class2) %>%
    summarise(area_ha = sum(area_ha)) %>%
    mutate(Percentage = paste0(round(area_ha/sum(area_ha)*100,2)))


#Sao José 2020----
#library(dplyr)
colnames(tab18)[2] <- "ID" #change name of column number 2
tab18.1 <- dplyr::inner_join(tab18,
                            code[, c("ID", "my_class2")],
                            by = "ID") #join tables, but only my_class2 column
tab18.2 <- subset(tab18.1, select = c(my_class2, area_ha))


##We want to sum areas with same classes (rows), AND add a new column to calculate percentage
#library(dplyr)
tab2020_SaoJose <- tab18.2 %>%
    group_by(my_class2) %>%
    summarise(area_ha = sum(area_ha)) %>%
    mutate(Percentage = paste0(round(area_ha/sum(area_ha)*100,2)))


#Santa Maria do Doce 2020----
#library(dplyr)
colnames(tab19)[2] <- "ID" #change name of column number 2
tab19.1 <- dplyr::inner_join(tab19,
                            code[, c("ID", "my_class2")],
                            by = "ID") #join tables, but only my_class2 column
tab19.2 <- subset(tab19.1, select = c(my_class2, area_ha))


##We want to sum areas with same classes (rows), AND add a new column to calculate percentage
#library(dplyr)
tab2020_SantaMariaDoDoce <- tab19.2 %>%
    group_by(my_class2) %>%
    summarise(area_ha = sum(area_ha)) %>%
    mutate(Percentage = paste0(round(area_ha/sum(area_ha)*100,2)))


#Suaçuí Grande 2020----
#library(dplyr)
colnames(tab20)[2] <- "ID" #change name of column number 2
tab20.1 <- dplyr::inner_join(tab20,
                             code[, c("ID", "my_class2")],
                             by = "ID") #join tables, but only my_class2 column
tab20.2 <- subset(tab20.1, select = c(my_class2, area_ha))


##We want to sum areas with same classes (rows), AND add a new column to calculate percentage
#library(dplyr)
tab2020_Suacui <- tab20.2 %>%
    group_by(my_class2) %>%
    summarise(area_ha = sum(area_ha)) %>%
    mutate(Percentage = paste0(round(area_ha/sum(area_ha)*100,2)))



### Saving the results of frequency in txt (Do not forget to change file name for each subwatershed).
write.csv(tab1985_bhrd,
          "./results/mapbiomas-col6/modified/area-uso-1985_bhrd1.csv",
          row.names = TRUE)

write.csv(tab1985_Caratinga,
          "./results/mapbiomas-col6/modified/area-uso-1985_Caratinga1.csv",
          row.names = TRUE)

write.csv(tab1985_Guandu,
          "./results/mapbiomas-col6/modified/area-uso-1985_Guandu1.csv",
          row.names = TRUE)

write.csv(tab1985_Manhuacu,
          "./results/mapbiomas-col6/modified/area-uso-1985_Manhuacu1.csv",
          row.names = TRUE)

write.csv(tab1985_Pira,
          "./results/mapbiomas-col6/modified/area-uso-1985_Piracicaba1.csv",
          row.names = TRUE)

write.csv(tab1985_Piranga,
          "./results/mapbiomas-col6/modified/area-uso-1985_Piranga1.csv",
          row.names = TRUE)

write.csv(tab1985_SantoAntonio,
          "./results/mapbiomas-col6/modified/area-uso-1985_SAntonio1.csv",
          row.names = TRUE)

write.csv(tab1985_SaoJose,
          "./results/mapbiomas-col6/modified/area-uso-1985_SJose1.csv",
          row.names = TRUE)

write.csv(tab1985_SantaMariaDoDoce,
          "./results/mapbiomas-col6/modified/area-uso-1985_SMariaDoDoce1.csv", row.names = TRUE)

write.csv(tab1985_Suacui,
          "./results/mapbiomas-col6/modified/area-uso-1985_SuacuiGrande1.csv", row.names = TRUE)



write.csv(tab2020_bhrd,
          "./results/mapbiomas-col6/modified/area-uso-2020_bhrd1.csv",
          row.names = TRUE)

write.csv(tab2020_Caratinga,
          "./results/mapbiomas-col6/modified/area-uso-2020_Caratinga1.csv",
          row.names = TRUE)

write.csv(tab2020_Guandu,
          "./results/mapbiomas-col6/modified/area-uso-2020_Guandu1.csv",
          row.names = TRUE)

write.csv(tab2020_Manhuacu,
          "./results/mapbiomas-col6/modified/area-uso-2020_Manhuacu1.csv",
          row.names = TRUE)

write.csv(tab2020_Pira,
          "./results/mapbiomas-col6/modified/area-uso-2020_Piracicaba1.csv",
          row.names = TRUE)

write.csv(tab2020_Piranga,
          "./results/mapbiomas-col6/modified/area-uso-2020_Piranga1.csv",
          row.names = TRUE)

write.csv(tab2020_SantoAntonio,
          "./results/mapbiomas-col6/modified/area-uso-2020_SAntonio1.csv",
          row.names = TRUE)

write.csv(tab2020_SaoJose,
          "./results/mapbiomas-col6/modified/area-uso-2020_SJose1.csv",
          row.names = TRUE)

write.csv(tab2020_SantaMariaDoDoce,
          "./results/mapbiomas-col6/modified/area-uso-2020_SMariaDoDoce1.csv", row.names = TRUE)

write.csv(tab2020_Suacui,
          "./results/mapbiomas-col6/modified/area-uso-2020_SuacuiGrande1.csv", row.names = TRUE)


#---------------------------------------------------------------------------------------

## We can also calculate descriptive statistics, where sum is what we want:
#library(doBy)
#tab4 <- summaryBy(area_ha ~ my_classes, data=tab2, FUN=c(length,sum,mean,sd))
#tab4


#----------------- MAKING GRAPHS -------------------#
##Plot in a graph
### To remove scientific format of numbers
options(scipen = 999)

library(ggplot2)

## without colors
png(file="./figs/grafico_classes1985_bhrd-Manhuacu.png", height=15, width=20, unit="cm", res=300) #to save image
ggplot(tab2020_bhrd, aes(reorder(my_class2, -area_ha, sum), area_ha, width=.7)) + #width faz a barra ficar mais fina (ou grossa)
    geom_col() +
    theme_classic() +
    labs(y = "Área (ha)", x = NULL) +
    theme (axis.text = element_text(size = 10), axis.title=element_text(size=10),
           axis.text.x=element_text(size = 10, angle = 45, hjust = 1)) #hjust adjust text below axis x
dev.off()


##The palette colors
palette <- c("#FFD966", "#1F4423", "#0000FF", "#32CD32", "#E974ED", "#935132", "#aa0000", "#FF99FF", "#af2a2a")

png(file="./figs/grafico_classes_bhrd.png", height=15, width=20, unit="cm", res=300) #to save image
ggplot(tab2019_bhrd, aes(reorder(my_class, -area_ha, sum), area_ha, fill = my_classes, width=.7)) + #width faz a barra ficar mais fina (ou grossa)
    geom_col(fill = palette) +
    theme_classic() +
    labs(y = "Área (ha)", x = NULL) +
    theme (axis.text = element_text(size = 10), axis.title=element_text(size=10),
           axis.text.x=element_text(size = 10, angle = 45, hjust = 1)) #hjust adjust text below axis x
dev.off()
