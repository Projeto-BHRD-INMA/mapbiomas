####################################################################
###         CALCULATE LAND COVER USE AREA FOR PROTECTED AREAS
###
### By: Danielle de Oliveira Moreira
### date: 14/07/2020    updated:
####################################################################


library(raster)
library(rgdal) #carregar shp

####Loading files mapbiomas 2019

#Protected areas shapefile for the Doce River watershed
pa <- shapefile('./data/shp/ucstodas_bhrd_wgs84.shp')
crs(pa)

#Visualized shp table
pa.table <- as.data.frame(pa)
View(pa.table)

#Mapbiomas Collection 5 - land use map
uso_1985 <- raster("./data/raster/mapbiomas5_bhrdCompleto/mapbiomas-col5-coverage-1985-bhrd.tif")
uso_2019 <- raster("./data/raster/mapbiomas5_bhrdCompleto/mapbiomas-col5-coverage-2019-bhrd.tif")
crs(uso_1985)

plot(uso_1985)
plot(pa, add = TRUE)

#Crop land use map for protected areas
uso1985_crop <- crop(uso_1985, extent(pa))
uso2019_crop <- crop(uso_2019, extent(pa))

#Adding a mask to cut exactly the limits of protected areas
uso1985_pa <- mask(uso1985_crop, pa)
uso2019_pa <- mask(uso2019_crop, pa)

plot(uso1985_pa)
plot(pa, add = TRUE)

#calculating the area of a cell for all protected areas.
##First, identify the name (in "names" of "uso" object) of the column to group_by.
##Now calculate the area
library(dplyr)
area_uso1985_pa <- as.data.frame(uso1985_pa) %>%
    group_by(mapbiomas.col5.coverage.1985.bhrd) %>%
    tally() %>%
    mutate(area_ha = n * 0.09) #multiplying by 0.09ha or 900m2, area of each cell.

area_uso1985_pa

area_uso2019_pa <- as.data.frame(uso2019_pa) %>%
    group_by(mapbiomas.col5.coverage.2019.bhrd) %>%
    tally() %>%
    mutate(area_ha = n * 0.09) #multiplying by 0.09ha or 900m2, area of each cell.

area_uso2019_pa

#Save the results in txt.
write.csv(area_uso1985_pa,"./results/mapbiomas_wgs84/Completo/raw/area-uso-ucs-1985_bhrd.csv",
          row.names = TRUE)

write.csv(area_uso2019_pa,"./results/mapbiomas_wgs84/Completo/raw/area-uso-ucs-2019_bhrd.csv",
          row.names = TRUE)


#----------------- MANIPULATING DATA -------------------#
# Manipulating table.
## Join tables to insert information of land cover use

#Opening table with land cover use codes
code <- read.csv2("./results/mapbiomas_wgs84/legend_col5_mapbiomas.csv", encoding="utf-8")

#library(dplyr)
colnames(area_uso1985_pa)[1] <- "ID" #change name of column number 2
tab_1985 <- dplyr::inner_join(area_uso1985_pa,
                          code[, c("ID", "my_class2")],
                          by = "ID") #join tables, but only my_class column
tab_1985_1 <- subset(tab_1985, select = c(my_class2, area_ha))

colnames(area_uso2019_pa)[1] <- "ID" #change name of column number 2
tab_2019 <- dplyr::inner_join(area_uso2019_pa,
                         code[, c("ID", "my_class2")],
                         by = "ID") #join tables, but only my_class column
tab_2019_1 <- subset(tab_2019, select = c(my_class2, area_ha))


##To sum areas with same classes (rows) AND add a new column (percentage)
#library(dplyr)
tab1985_pa <- tab_1985_1 %>%
    group_by(my_class2) %>%
    summarise(area_ha = sum(area_ha)) %>%
    mutate(Percentage = paste0(round(area_ha/sum(area_ha)*100,2)))
#slice(-c(10)) %>% #to remove row with NA

tab2019_pa <- tab_2019_1 %>%
    group_by(my_class2) %>%
    summarise(area_ha = sum(area_ha)) %>%
    mutate(Percentage = paste0(round(area_ha/sum(area_ha)*100,2)))
#slice(-c(10)) %>% #to remove row with NA

#Save the results of frequency in txt.
write.csv(tab1985_pa,
          "./results/mapbiomas_wgs84/Completo/modified/8_classes/area-uso-ucs-1985.csv",
          row.names = TRUE)

write.csv(tab2019_pa,
          "./results/mapbiomas_wgs84/Completo/modified/8_classes/area-uso-ucs-2019.csv",
          row.names = TRUE)



#----------FOR SUSTAINABLE PROTECTED AREAS TYPES-------------------------------------

#Check protected area for Sustainable Use (US - Uso Sustentável) only, since protection is less rigorous than Full Protection (PI - Proteção Integral)
pa@data[["GRUPO4"]] #to check the names of subdivisions of shp and choose one type

pa_us <- subset(pa, GRUPO4=="US")

plot(pa_us)


#Crop land use map for Sustainable Use areas
uso1985_us_crop <- crop(uso_1985, extent(pa_us))
uso2019_us_crop <- crop(uso_2019, extent(pa_us))

#Adding a mask to cut exactly the limits of protected areas
uso1985_us_mask <- mask(uso1985_us_crop, pa_us)
uso2019_us_mask <- mask(uso2019_us_crop, pa_us)

plot(uso1985_us_mask)
plot(pa_us, add = TRUE)

#calculating the area of a cell for these protected areas.
##First, identify the name (in "names" of "uso" object) of the column to group_by.
##Now calculate the area
library(dplyr)
area_uso1985_us <- as.data.frame(uso1985_us_mask) %>%
    group_by(mapbiomas.col5.coverage.1985.bhrd) %>%
    tally() %>%
    mutate(area_ha = n * 0.09) #multiplying by 0.09ha or 900m2, area of each cell.

area_uso1985_us

area_uso2019_us <- as.data.frame(uso2019_us_mask) %>%
    group_by(mapbiomas.col5.coverage.2019.bhrd) %>%
    tally() %>%
    mutate(area_ha = n * 0.09) #multiplying by 0.09ha or 900m2, area of each cell.

area_uso2019_us

#Save the results in txt.
write.csv(area_uso1985_us,"./results/mapbiomas_wgs84/Completo/raw/area-uso-ucs-us-1985_bhrd.csv", row.names = TRUE)

write.csv(area_uso2019_us,"./results/mapbiomas_wgs84/Completo/raw/area-uso-ucs-us-2019_bhrd.csv", row.names = TRUE)


#-------
#Check protected area for Área de Proteção Ambiental only, since protection is not rigorous
pa@data[["CATEGORI3"]] #to check the names of subdivisions of shp and choose one type

pa_apa <- subset(pa, CATEGORI3=="Área de Proteção Ambiental")

plot(pa_apa)

#Crop land use map for Area de Protecao Ambiental areas
uso1985_apa_crop <- crop(uso_1985, extent(pa_apa))
uso2019_apa_crop <- crop(uso_2019, extent(pa_apa))

#Adding a mask to cut exactly the limits of protected areas
uso1985_apa_mask <- mask(uso1985_apa_crop, pa_apa)
uso2019_apa_mask <- mask(uso2019_apa_crop, pa_apa)

plot(uso1985_apa_mask)
plot(pa_apa, add = TRUE)

#calculating the area of a cell for these protected areas.
##First, identify the name (in "names" of "uso" object) of the column to group_by.
##Now calculate the area
library(dplyr)
area_uso1985_apa <- as.data.frame(uso1985_apa_mask) %>%
    group_by(mapbiomas.col5.coverage.1985.bhrd) %>%
    tally() %>%
    mutate(area_ha = n * 0.09) #multiplying by 0.09ha or 900m2, area of each cell.

area_uso1985_apa

area_uso2019_apa <- as.data.frame(uso2019_apa_mask) %>%
    group_by(mapbiomas.col5.coverage.2019.bhrd) %>%
    tally() %>%
    mutate(area_ha = n * 0.09) #multiplying by 0.09ha or 900m2, area of each cell.

area_uso2019_apa

#Save the results in txt.
write.csv(area_uso1985_apa,"./results/mapbiomas_wgs84/Completo/raw/area-uso-ucs-apa-1985_bhrd.csv", row.names = TRUE)

write.csv(area_uso2019_apa,"./results/mapbiomas_wgs84/Completo/raw/area-uso-ucs-apa-2019_bhrd.csv", row.names = TRUE)


#----------------- MANIPULATING DATA FOR SUSTAINABLE PROTECTED AREAS TYPES -------------------#
# Manipulating table.
## Join tables to insert information of land cover use

#Opening table with land cover use codes
code <- read.csv2("./results/mapbiomas_wgs84/legend_col5_mapbiomas.csv", encoding="utf-8")

#library(dplyr)
colnames(area_uso1985_us)[1] <- "ID" #change name of column number 2
tab_1985_us <- dplyr::inner_join(area_uso1985_us,
                              code[, c("ID", "my_class2")],
                              by = "ID") #join tables, but only my_class column
tab_1985_1_us <- subset(tab_1985_us, select = c(my_class2, area_ha))

colnames(area_uso2019_us)[1] <- "ID" #change name of column number 2
tab_2019_us <- dplyr::inner_join(area_uso2019_us,
                              code[, c("ID", "my_class2")],
                              by = "ID") #join tables, but only my_class column
tab_2019_1_us <- subset(tab_2019_us, select = c(my_class2, area_ha))

#-----
colnames(area_uso1985_apa)[1] <- "ID" #change name of column number 2
tab_1985_apa <- dplyr::inner_join(area_uso1985_apa,
                                 code[, c("ID", "my_class2")],
                                 by = "ID") #join tables, but only my_class column
tab_1985_1_apa <- subset(tab_1985_apa, select = c(my_class2, area_ha))


colnames(area_uso2019_apa)[1] <- "ID" #change name of column number 2
tab_2019_apa <- dplyr::inner_join(area_uso2019_apa,
                                 code[, c("ID", "my_class2")],
                                 by = "ID") #join tables, but only my_class column
tab_2019_1_apa <- subset(tab_2019_apa, select = c(my_class2, area_ha))

#----------
##To sum areas with same classes (rows) AND add a new column (percentage)
#library(dplyr)
tab1985_us_final <- tab_1985_1_us %>%
    group_by(my_class2) %>%
    summarise(area_ha = sum(area_ha)) %>%
    mutate(Percentage = paste0(round(area_ha/sum(area_ha)*100,2)))
#slice(-c(10)) %>% #to remove row with NA

tab2019_us_final <- tab_2019_1_us %>%
    group_by(my_class2) %>%
    summarise(area_ha = sum(area_ha)) %>%
    mutate(Percentage = paste0(round(area_ha/sum(area_ha)*100,2)))
#slice(-c(10)) %>% #to remove row with NA

#-------

tab1985_apa_final <- tab_1985_1_apa %>%
    group_by(my_class2) %>%
    summarise(area_ha = sum(area_ha)) %>%
    mutate(Percentage = paste0(round(area_ha/sum(area_ha)*100,2)))
#slice(-c(10)) %>% #to remove row with NA

tab2019_apa_final <- tab_2019_1_apa %>%
    group_by(my_class2) %>%
    summarise(area_ha = sum(area_ha)) %>%
    mutate(Percentage = paste0(round(area_ha/sum(area_ha)*100,2)))
#slice(-c(10)) %>% #to remove row with NA

#Save the results of frequency in txt.
write.csv(tab1985_us_final,
          "./results/mapbiomas_wgs84/Completo/modified/8_classes/area-uso-ucs-us-1985.csv",
          row.names = TRUE)

write.csv(tab2019_us_final,
          "./results/mapbiomas_wgs84/Completo/modified/8_classes/area-uso-ucs-us-2019.csv",
          row.names = TRUE)

write.csv(tab1985_apa_final,
          "./results/mapbiomas_wgs84/Completo/modified/8_classes/area-uso-ucs-apa-1985.csv",
          row.names = TRUE)

write.csv(tab2019_apa_final,
          "./results/mapbiomas_wgs84/Completo/modified/8_classes/area-uso-ucs-apa-2019.csv",
          row.names = TRUE)


#----------FOR FULL PROTECTED AREAS TYPES-------------------------------------

#Check protected area for Full Protection (PI - Proteção Integral) only, since protection is more rigorous than (US - Uso Sustentável)
pa@data[["GRUPO4"]] #to check the names of subdivisions of shp and choose one type

pa_pi <- subset(pa, GRUPO4=="PI")

plot(pa_pi)


#Crop land use map for Sustainable Use areas
uso1985_pi_crop <- crop(uso_1985, extent(pa_pi))
uso2019_pi_crop <- crop(uso_2019, extent(pa_pi))

#Adding a mask to cut exactly the limits of protected areas
uso1985_pi_mask <- mask(uso1985_pi_crop, pa_pi)
uso2019_pi_mask <- mask(uso2019_pi_crop, pa_pi)

plot(uso1985_pi_mask)
plot(pa_pi, add = TRUE)


#--------
#calculating the area of a cell for these protected areas.
##First, identify the name (in "names" of "uso" object) of the column to group_by.
##Now calculate the area
library(dplyr)
area_uso1985_pi <- as.data.frame(uso1985_pi_mask) %>%
    group_by(mapbiomas.col5.coverage.1985.bhrd) %>%
    tally() %>%
    mutate(area_ha = n * 0.09) #multiplying by 0.09ha or 900m2, area of each cell.

area_uso1985_pi

area_uso2019_pi <- as.data.frame(uso2019_pi_mask) %>%
    group_by(mapbiomas.col5.coverage.2019.bhrd) %>%
    tally() %>%
    mutate(area_ha = n * 0.09) #multiplying by 0.09ha or 900m2, area of each cell.

area_uso2019_pi

#Save the results in txt.
write.csv(area_uso1985_pi,"./results/mapbiomas_wgs84/Completo/raw/area-uso-ucs-pi-1985_bhrd.csv", row.names = TRUE)

write.csv(area_uso2019_pi,"./results/mapbiomas_wgs84/Completo/raw/area-uso-ucs-pi-2019_bhrd.csv", row.names = TRUE)


#----------------- MANIPULATING DATA FOR SUSTAINABLE PROTECTED AREAS TYPES -------------------#
# Manipulating table.
## Join tables to insert information of land cover use

#Opening table with land cover use codes
code <- read.csv2("./results/mapbiomas_wgs84/legend_col5_mapbiomas.csv", encoding="utf-8")

#library(dplyr)
colnames(area_uso1985_pi)[1] <- "ID" #change name of column number 2
tab_1985_pi <- dplyr::inner_join(area_uso1985_pi,
                                 code[, c("ID", "my_class2")],
                                 by = "ID") #join tables, but only my_class column
tab_1985_1_pi <- subset(tab_1985_pi, select = c(my_class2, area_ha))

colnames(area_uso2019_pi)[1] <- "ID" #change name of column number 2
tab_2019_pi <- dplyr::inner_join(area_uso2019_pi,
                                 code[, c("ID", "my_class2")],
                                 by = "ID") #join tables, but only my_class column
tab_2019_1_pi <- subset(tab_2019_pi, select = c(my_class2, area_ha))


#----------
##To sum areas with same classes (rows) AND add a new column (percentage)
#library(dplyr)
tab1985_pi_final <- tab_1985_1_pi %>%
    group_by(my_class2) %>%
    summarise(area_ha = sum(area_ha)) %>%
    mutate(Percentage = paste0(round(area_ha/sum(area_ha)*100,2)))
#slice(-c(10)) %>% #to remove row with NA

tab2019_pi_final <- tab_2019_1_pi %>%
    group_by(my_class2) %>%
    summarise(area_ha = sum(area_ha)) %>%
    mutate(Percentage = paste0(round(area_ha/sum(area_ha)*100,2)))
#slice(-c(10)) %>% #to remove row with NA


#Save the results of frequency in txt.
write.csv(tab1985_pi_final,
          "./results/mapbiomas_wgs84/Completo/modified/8_classes/area-uso-ucs-pi-1985.csv",
          row.names = TRUE)

write.csv(tab2019_pi_final,
          "./results/mapbiomas_wgs84/Completo/modified/8_classes/area-uso-ucs-pi-2019.csv",
          row.names = TRUE)


