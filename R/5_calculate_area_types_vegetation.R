####################################################################
###         CALCULATE AREA OF TYPES OF VEGETATION BHRD
###
### By: Danielle de Oliveira Moreira
### date: 02/09/2021    updated: 14/03/2022
####################################################################


library(raster)
veg <- shapefile('./data/shp/vege-bhrd-ibge-wgs84_dissolv.shp')
crs(veg)

plot(veg)

veg$area_ha <- area(veg) / 10000
#veg$area_sqkm <- area(veg) / 1000000


veg2 <- as.data.frame(veg)
colnames(veg2)

##We want to sum areas with same classes (rows), AND add a new column to calculate percentage
library(dplyr)
area_veg <- veg2 %>%
    group_by(legenda_1) %>%
    summarise(area_ha = sum(area_ha)) %>%
    mutate(Percentage = paste0(round(area_ha/sum(area_ha)*100,2)))
#slice(-c(10)) %>% #to remove row with NA

#write.csv(area, "./results/area-vegetacao-bhrd.csv",
          row.names = TRUE)


#CALCULATE REMAINING AREAS FOR EACH VEGETATION TYPES IN 2020 -----------------------------------

uso_bhrd <- raster("./data/mapbiomas-col6-bhrd/raster/2020/coverage-2020.tif")

plot(uso_bhrd)
plot(veg, add = TRUE)


#choose a vegetation type from shp. We are gonna use col legenda_1
head(veg)
tail(veg)


veg@data[["legenda_1"]] #to check the names of subdivisions of shp and choose one type

veg_campinarana <- subset(veg, legenda_1=="Campinarana")
veg_savana <- subset(veg, legenda_1=="Savana")
veg_agua <- subset(veg, legenda_1=="Corpo d'\xe1gua continental")
veg_contato <- subset(veg, legenda_1=="Contato (Contato (Ec\xf3tono e Encrave)")
veg_semidecidual <- subset(veg, legenda_1=="Floresta Estacional Semidecidual")
veg_pioneira <- subset(veg, legenda_1=="Forma\xe7\xe3o Pioneira")
veg_ombrofila <- subset(veg, legenda_1=="Floresta Ombr\xf3fila Densa")

#Crop uso_2020_bhrd raster for each vegetation type
#Campinarana
uso_campinarana_crop <- crop(uso_bhrd, extent(veg_campinarana))

#Savana
uso_savana_crop <- crop(uso_bhrd, extent(veg_savana))

#Corpo d'água continental
uso_agua_crop <- crop(uso_bhrd, extent(veg_agua))

#Contato (Ecótono e Encrave)
uso_contato_crop <- crop(uso_bhrd, extent(veg_contato))

#Floresta Estacional Semidecidual
uso_semidecidual_crop <- crop(uso_bhrd, extent(veg_semidecidual))

#Formação Pioneira
uso_pioneira_crop <- crop(uso_bhrd, extent(veg_pioneira))

#Floresta Ombrófila Densa
uso_ombrofila_crop <- crop(uso_bhrd, extent(veg_ombrofila))


#Mask uso_bhrd raster for each vegetation type
#Campinarana
uso_campinarana_mask <- mask(uso_campinarana_crop, veg_campinarana)

#Savana
uso_savana_mask <- mask(uso_savana_crop, veg_savana)

#Corpo d'água continental
uso_agua_mask <- mask(uso_agua_crop, veg_agua)

#Contato (Ecótono e Encrave)
uso_contato_mask <- mask(uso_contato_crop, veg_contato)

#Floresta Estacional Semidecidual
uso_semidecidual_mask <- mask(uso_semidecidual_crop, veg_semidecidual)

#Formação Pioneira
uso_pioneira_mask <- mask(uso_pioneira_crop, veg_pioneira)

#Floresta Ombrófila Densa
uso_ombrofila_mask <- mask(uso_ombrofila_crop, veg_ombrofila)

plot(uso_semidecidual_mask)

##
##
##
#Calculate areas of a cell for each vegetation type in 2020
##First, identify the name (in "names" of object) of the column to group_by.

library(dplyr)

#For Campinarana
area_uso_campinarana <- as.data.frame(uso_campinarana_mask) %>%
    group_by(coverage.2020) %>%
    tally() %>%
    mutate(area_ha = n * 0.09) #multiplying by 0.09ha or 900m2, area of each cell.

#Savana
area_uso_savana <- as.data.frame(uso_savana_mask) %>%
    group_by(coverage.2020) %>%
    tally() %>%
    mutate(area_ha = n * 0.09)

#Corpo d'água continental
area_uso_agua <- as.data.frame(uso_agua_mask) %>%
    group_by(coverage.2020) %>%
    tally() %>%
    mutate(area_ha = n * 0.09)

#Contato (Ecótono e Encrave)
area_uso_contato <- as.data.frame(uso_contato_mask) %>%
    group_by(coverage.2020) %>%
    tally() %>%
    mutate(area_ha = n * 0.09)

#Floresta Estacional Semidecidual
area_uso_semidecidual <- as.data.frame(uso_semidecidual_mask) %>%
    group_by(coverage.2020) %>%
    tally() %>%
    mutate(area_ha = n * 0.09)

#Formação Pioneira
area_uso_pioneira <- as.data.frame(uso_pioneira_mask) %>%
    group_by(coverage.2020) %>%
    tally() %>%
    mutate(area_ha = n * 0.09)

#Floresta Ombrófila Densa
area_uso_ombrofila <- as.data.frame(uso_ombrofila_mask) %>%
    group_by(coverage.2020) %>%
    tally() %>%
    mutate(area_ha = n * 0.09)
