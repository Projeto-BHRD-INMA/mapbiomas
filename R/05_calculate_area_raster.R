####################################################################
###         CALCULATE AREA FOR EACH MICRO WATERSHELTER
###
### By: Danielle de Oliveira Moreira
### date: 18/05/2020
#################################################################

library(dplyr)

#Loading raster

uso2018_micro <- raster("./data/albers/mapbiomas/microbacias/mapbiomas.2018.Manhuacu.tif")

plot(uso2018_micro)

#calculating the area of a cell.
##First, identify the name (in "names") of the column to group_by. In this case, "mapbiomas.2018.baixoRDoce"
uso2018_micro
##Now calculate the area
area.uso <- as.data.frame(uso2018_micro) %>%
    group_by(mapbiomas.2018.Manhuacu) %>%
    tally() %>%
    mutate(area_ha = n * 0.09) #multiplying by 0.09ha or 900m2, area of each cell.

area.uso

#Save the results of frequency in txt.
write.csv(area.uso,"./results/mapbiomas/microbacias/area-uso-2018_Manhuacu.csv", row.names = TRUE)
