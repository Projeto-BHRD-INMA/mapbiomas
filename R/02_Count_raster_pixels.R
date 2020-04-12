########################################################
### SCRIPT TO COUNT PIXELS OF A RASTER AND CALCULATE####
###             THE AREA OF LAND COVER FEATURES     ####
### Por: Danielle de O. Moreira                     ####
### Data: 06/04/2020                                ####
########################################################

library(raster)
library(dplyr)

#FOR A SINGLE FILE
#Creating an object with the raster file
uso <- raster("./data/albers/mapbiomas.none.2017.tif")

#Calculating the frequency: gives the number (count) of pixels (cells) in each class
frequencia <- freq(uso)

#Save the results of frequency in txt.
write.csv(frequencia,"./results/uso-freq-2017.csv")

#calculating the area of a cell.
##First, identify the name (in "names") of the column to group_by. In this case, "mapbiomas.2018.bhrd.1km"
uso
##Now calculate the area
area.uso <- as.data.frame(uso) %>%
                group_by(mapbiomas.none.1985) %>%
                tally() %>%
                mutate(area_ha = n * 0.09) #multiplying by 0.09ha or 900m2, area of each cell.

area.uso

#Save the results of frequency in txt.
write.csv(area.uso,"./results/area-uso-1985.csv", row.names = TRUE)

#################################################################
## Doing for several files in sequence (not a loop)
uso1 <- raster("./data/albers/mapbiomas.none.1985.tif")
area.uso1 <- as.data.frame(uso1) %>%
    group_by(mapbiomas.none.1985) %>%
    tally() %>%
    mutate(area_ha = n * 0.09)
write.csv(area.uso1,"./results/area-uso-1985.csv", row.names = TRUE)

uso2 <- raster("./data/albers/mapbiomas.none.1986.tif")
area.uso2 <- as.data.frame(uso2) %>%
    group_by(mapbiomas.none.1986) %>%
    tally() %>%
    mutate(area_ha = n * 0.09)
write.csv(area.uso2,"./results/area-uso-1986.csv", row.names = TRUE)

uso3 <- raster("./data/albers/mapbiomas.none.1987.tif")
area.uso3 <- as.data.frame(uso3) %>%
    group_by(mapbiomas.none.1987) %>%
    tally() %>%
    mutate(area_ha = n * 0.09)
write.csv(area.uso3,"./results/area-uso-1987.csv", row.names = TRUE)

uso4 <- raster("./data/albers/mapbiomas.none.1988.tif")
area.uso4 <- as.data.frame(uso4) %>%
    group_by(mapbiomas.none.1988) %>%
    tally() %>%
    mutate(area_ha = n * 0.09)
write.csv(area.uso4,"./results/area-uso-1988.csv", row.names = TRUE)

uso5 <- raster("./data/albers/mapbiomas.none.1989.tif")
area.uso5 <- as.data.frame(uso5) %>%
    group_by(mapbiomas.none.1989) %>%
    tally() %>%
    mutate(area_ha = n * 0.09)
write.csv(area.uso5,"./results/area-uso-1989.csv", row.names = TRUE)

uso6 <- raster("./data/albers/mapbiomas.none.1990.tif")
area.uso6 <- as.data.frame(uso6) %>%
    group_by(mapbiomas.none.1990) %>%
    tally() %>%
    mutate(area_ha = n * 0.09)
write.csv(area.uso6,"./results/area-uso-1990.csv", row.names = TRUE)

uso7 <- raster("./data/albers/mapbiomas.none.1991.tif")
area.uso7 <- as.data.frame(uso7) %>%
    group_by(mapbiomas.none.1991) %>%
    tally() %>%
    mutate(area_ha = n * 0.09)
write.csv(area.uso7,"./results/area-uso-1991.csv", row.names = TRUE)

uso8 <- raster("./data/albers/mapbiomas.none.1992.tif")
area.uso8 <- as.data.frame(uso8) %>%
    group_by(mapbiomas.none.1992) %>%
    tally() %>%
    mutate(area_ha = n * 0.09)
write.csv(area.uso8,"./results/area-uso-1992.csv", row.names = TRUE)

uso9 <- raster("./data/albers/mapbiomas.none.1993.tif")
area.uso9 <- as.data.frame(uso9) %>%
    group_by(mapbiomas.none.1993) %>%
    tally() %>%
    mutate(area_ha = n * 0.09)
write.csv(area.uso9,"./results/area-uso-1993.csv", row.names = TRUE)

uso10 <- raster("./data/albers/mapbiomas.none.1994.tif")
area.uso10 <- as.data.frame(uso10) %>%
    group_by(mapbiomas.none.1994) %>%
    tally() %>%
    mutate(area_ha = n * 0.09)
write.csv(area.uso10,"./results/area-uso-1994.csv", row.names = TRUE)

########################################################

#FOR SEVERAL FILES (LOOP) - ATTENTION - UNFINISHED - NOT WORKING

#Directory where the files are
Dir <- "./data/MAPBIOMAS-SERIE-HISTORICA-30m"

#List of files
data <- list.files(Dir, pattern = ".tif", full.names = T)
data

#Loop to count pixels of raster files and save them.
dirsave <- "./output"
for (i in 1:length(data)) {
    print(i)
    layer <- raster(data[i])
    area.layer <- as.data.frame(layer) %>%
        group_by(names(layer)) %>%
        tally() %>%
        mutate(area_ha = n * 0.09)
    write.csv(area.layer, paste(dirsave, paste0(names(layer), 'csv.'),
                           row.names = TRUE))
}

#testando o primeiro arquivo para ver se dá certo
i = 1
print(i)
layer <- raster(data[i])
area.layer <- as.data.frame(layer) %>%
    group_by(names(layer)) %>%
    tally() %>%
    mutate(area_ha = n * 0.09)
write.csv(area.layer, paste(dirsave, paste0(names(layer), 'csv.'),
                            row.names = TRUE))
