########################################################
### SCRIPT TO COUNT PIXELS OF A RASTER              ####
### Por: Danielle de O. Moreira                     ####
### Data: 01/04/2020                                ####
########################################################

library(raster)
library(dplyr)

#FOR A SINGLE FILE
#Creating an object with the raster file
uso.2018 <- raster("./data/mapbiomas-none-2018.tif")

#Calculating the frequency: gives the number (count) of pixels (cells) in each class
freq(uso.2018)

#calculating the area of a cell.
##First, identify the name (in "names") of the column to group_by. In this case, "mapbiomas.2018.bhrd.1km"
uso.2018
##Now calculate the area
area.uso.2018 <- as.data.frame(uso.2018) %>%
                group_by(mapbiomas.none.2018) %>%
                tally() %>%
                mutate(area_ha = n * 0.09) #multiplying by 0.09ha or 900m2, area of each cell.

area.uso.2018

#Save the results of frequency in txt.
write.csv(area.uso.2018,"./results/area-uso-2018.csv", row.names = TRUE)



########################################################

#FOR SEVERAL FILES (LOOP) - ATENTION - UNFINISHED - NOT WORKING

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
