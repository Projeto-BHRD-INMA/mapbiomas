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
uso <- raster("./data/albers/mapbiomas/mapbiomas.none.2015.tif")
plot(uso)
uso
head(uso)


#trim crops a RasterLayer by removing the outer rows and columns that only contain NA values
#trim(uso)
#head(uso)


# To transform pixels with NA to zeros
#uso[is.na(uso)] <- 0
#uso
#head(uso)
#plot(uso)

#Calculating the frequency: gives the number (count) of pixels (cells) in each class
frequencia <- freq(uso)

#Save the results of frequency in txt.
write.csv(frequencia,"./uso-freq-2015.csv")

#calculating the area of a cell.
##First, identify the name (in "names") of the column to group_by. In this case, "mapbiomas.none.2015"
uso
##Now calculate the area
area.uso <- as.data.frame(uso) %>%
                group_by(mapbiomas.none.2015) %>%
                tally() %>%
                mutate(area_ha = n * 0.09) #multiplying by 0.09ha or 900m2, area of each cell.

area.uso

#Save the results of frequency in txt.
write.csv(area.uso,"./results/area-uso-2015.csv", row.names = TRUE)



#################################################################
## Doing for several files in sequence (not a loop)

##################################################################


uso1 <- raster("./data/albers/mapbiomas/mapbiomas.none.1985.tif")
area.uso1 <- as.data.frame(uso1) %>%
    group_by(mapbiomas.none.1985) %>%
    tally() %>%
    mutate(area_ha = n * 0.09)
write.csv(area.uso1,"./results/mapbiomas/area-uso-1985.csv", row.names = TRUE)

uso2 <- raster("./data/albers/mapbiomas/mapbiomas.none.1986.tif")
area.uso2 <- as.data.frame(uso2) %>%
    group_by(mapbiomas.none.1986) %>%
    tally() %>%
    mutate(area_ha = n * 0.09)
write.csv(area.uso2,"./results/mapbiomas/area-uso-1986.csv", row.names = TRUE)

uso3 <- raster("./data/albers/mapbiomas/mapbiomas.none.1987.tif")
area.uso3 <- as.data.frame(uso3) %>%
    group_by(mapbiomas.none.1987) %>%
    tally() %>%
    mutate(area_ha = n * 0.09)
write.csv(area.uso3,"./results/mapbiomas/area-uso-1987.csv", row.names = TRUE)

uso4 <- raster("./data/albers/mapbiomas/mapbiomas.none.1988.tif")
area.uso4 <- as.data.frame(uso4) %>%
    group_by(mapbiomas.none.1988) %>%
    tally() %>%
    mutate(area_ha = n * 0.09)
write.csv(area.uso4,"./results/mapbiomas/area-uso-1988.csv", row.names = TRUE)

uso5 <- raster("./data/albers/mapbiomas/mapbiomas.none.1989.tif")
area.uso5 <- as.data.frame(uso5) %>%
    group_by(mapbiomas.none.1989) %>%
    tally() %>%
    mutate(area_ha = n * 0.09)
write.csv(area.uso5,"./results/mapbiomas/area-uso-1989.csv", row.names = TRUE)

uso6 <- raster("./data/albers/mapbiomas/mapbiomas.none.1990.tif")
area.uso6 <- as.data.frame(uso6) %>%
    group_by(mapbiomas.none.1990) %>%
    tally() %>%
    mutate(area_ha = n * 0.09)
write.csv(area.uso6,"./results/mapbiomas/area-uso-1990.csv", row.names = TRUE)

uso7 <- raster("./data/albers/mapbiomas/mapbiomas.none.1991.tif")
area.uso7 <- as.data.frame(uso7) %>%
    group_by(mapbiomas.none.1991) %>%
    tally() %>%
    mutate(area_ha = n * 0.09)
write.csv(area.uso7,"./results/mapbiomas/area-uso-1991.csv", row.names = TRUE)

uso8 <- raster("./data/albers/mapbiomas/mapbiomas.none.1992.tif")
area.uso8 <- as.data.frame(uso8) %>%
    group_by(mapbiomas.none.1992) %>%
    tally() %>%
    mutate(area_ha = n * 0.09)
write.csv(area.uso8,"./results/mapbiomas/area-uso-1992.csv", row.names = TRUE)

uso9 <- raster("./data/albers/mapbiomas/mapbiomas.none.1993.tif")
area.uso9 <- as.data.frame(uso9) %>%
    group_by(mapbiomas.none.1993) %>%
    tally() %>%
    mutate(area_ha = n * 0.09)
write.csv(area.uso9,"./results/mapbiomas/area-uso-1993.csv", row.names = TRUE)

uso10 <- raster("./data/albers/mapbiomas/mapbiomas.none.1994.tif")
area.uso10 <- as.data.frame(uso10) %>%
    group_by(mapbiomas.none.1994) %>%
    tally() %>%
    mutate(area_ha = n * 0.09)
write.csv(area.uso10,"./results/mapbiomas/area-uso-1994.csv", row.names = TRUE)

uso11 <- raster("./data/albers/mapbiomas/mapbiomas.none.1995.tif")
area.uso11 <- as.data.frame(uso11) %>%
    group_by(mapbiomas.none.1995) %>%
    tally() %>%
    mutate(area_ha = n * 0.09)
write.csv(area.uso11,"./results/mapbiomas/area-uso-1995.csv", row.names = TRUE)

uso12 <- raster("./data/albers/mapbiomas/mapbiomas.none.1996.tif")
area.uso12 <- as.data.frame(uso12) %>%
    group_by(mapbiomas.none.1996) %>%
    tally() %>%
    mutate(area_ha = n * 0.09)
write.csv(area.uso12,"./results/mapbiomas/area-uso-1996.csv", row.names = TRUE)

uso13 <- raster("./data/albers/mapbiomas/mapbiomas.none.1997.tif")
area.uso13 <- as.data.frame(uso13) %>%
    group_by(mapbiomas.none.1997) %>%
    tally() %>%
    mutate(area_ha = n * 0.09)
write.csv(area.uso13,"./results/mapbiomas/area-uso-1997.csv", row.names = TRUE)

uso14 <- raster("./data/albers/mapbiomas/mapbiomas.none.1998.tif")
area.uso14 <- as.data.frame(uso14) %>%
    group_by(mapbiomas.none.1998) %>%
    tally() %>%
    mutate(area_ha = n * 0.09)
write.csv(area.uso14,"./results/mapbiomas/area-uso-1998.csv", row.names = TRUE)

uso15 <- raster("./data/albers/mapbiomas/mapbiomas.none.1999.tif")
area.uso15 <- as.data.frame(uso15) %>%
    group_by(mapbiomas.none.1999) %>%
    tally() %>%
    mutate(area_ha = n * 0.09)
write.csv(area.uso15,"./results/mapbiomas/area-uso-1999.csv", row.names = TRUE)

uso16 <- raster("./data/albers/mapbiomas/mapbiomas.none.2000.tif")
area.uso16 <- as.data.frame(uso16) %>%
    group_by(mapbiomas.none.2000) %>%
    tally() %>%
    mutate(area_ha = n * 0.09)
write.csv(area.uso16,"./results/mapbiomas/area-uso-2000.csv", row.names = TRUE)

uso17 <- raster("./data/albers/mapbiomas/mapbiomas.none.2001.tif")
area.uso17 <- as.data.frame(uso17) %>%
    group_by(mapbiomas.none.2001) %>%
    tally() %>%
    mutate(area_ha = n * 0.09)
write.csv(area.uso17,"./results/mapbiomas/area-uso-2001.csv", row.names = TRUE)

uso18 <- raster("./data/albers/mapbiomas/mapbiomas.none.2002.tif")
area.uso18 <- as.data.frame(uso18) %>%
    group_by(mapbiomas.none.2002) %>%
    tally() %>%
    mutate(area_ha = n * 0.09)
write.csv(area.uso18,"./results/mapbiomas/area-uso-2002.csv", row.names = TRUE)

uso19 <- raster("./data/albers/mapbiomas/mapbiomas.none.2003.tif")
area.uso19 <- as.data.frame(uso19) %>%
    group_by(mapbiomas.none.2003) %>%
    tally() %>%
    mutate(area_ha = n * 0.09)
write.csv(area.uso19,"./results/mapbiomas/area-uso-2003.csv", row.names = TRUE)

uso20 <- raster("./data/albers/mapbiomas/mapbiomas.none.2004.tif")
area.uso20 <- as.data.frame(uso20) %>%
    group_by(mapbiomas.none.2004) %>%
    tally() %>%
    mutate(area_ha = n * 0.09)
write.csv(area.uso20,"./results/mapbiomas/area-uso-2004.csv", row.names = TRUE)

uso21 <- raster("./data/albers/mapbiomas/mapbiomas.none.2005.tif")
area.uso21 <- as.data.frame(uso21) %>%
    group_by(mapbiomas.none.2005) %>%
    tally() %>%
    mutate(area_ha = n * 0.09)
write.csv(area.uso21,"./results/mapbiomas/area-uso-2005.csv", row.names = TRUE)

uso22 <- raster("./data/albers/mapbiomas/mapbiomas.none.2006.tif")
area.uso22 <- as.data.frame(uso22) %>%
    group_by(mapbiomas.none.2006) %>%
    tally() %>%
    mutate(area_ha = n * 0.09)
write.csv(area.uso22,"./results/mapbiomas/area-uso-2006.csv", row.names = TRUE)

uso23 <- raster("./data/albers/mapbiomas/mapbiomas.none.2007.tif")
area.uso23 <- as.data.frame(uso23) %>%
    group_by(mapbiomas.none.2007) %>%
    tally() %>%
    mutate(area_ha = n * 0.09)
write.csv(area.uso23,"./results/mapbiomas/area-uso-2007.csv", row.names = TRUE)

uso24 <- raster("./data/albers/mapbiomas/mapbiomas.none.2008.tif")
area.uso24 <- as.data.frame(uso24) %>%
    group_by(mapbiomas.none.2008) %>%
    tally() %>%
    mutate(area_ha = n * 0.09)
write.csv(area.uso24,"./results/mapbiomas/area-uso-2008.csv", row.names = TRUE)

uso25 <- raster("./data/albers/mapbiomas/mapbiomas.none.2009.tif")
area.uso25 <- as.data.frame(uso25) %>%
    group_by(mapbiomas.none.2009) %>%
    tally() %>%
    mutate(area_ha = n * 0.09)
write.csv(area.uso25,"./results/mapbiomas/area-uso-2009.csv", row.names = TRUE)

uso26 <- raster("./data/albers/mapbiomas/mapbiomas.none.2010.tif")
area.uso26 <- as.data.frame(uso26) %>%
    group_by(mapbiomas.none.2010) %>%
    tally() %>%
    mutate(area_ha = n * 0.09)
write.csv(area.uso26,"./results/mapbiomas/area-uso-2010.csv", row.names = TRUE)

uso27 <- raster("./data/albers/mapbiomas/mapbiomas.none.2011.tif")
area.uso27 <- as.data.frame(uso27) %>%
    group_by(mapbiomas.none.2011) %>%
    tally() %>%
    mutate(area_ha = n * 0.09)
write.csv(area.uso27,"./results/mapbiomas/area-uso-2011.csv", row.names = TRUE)

uso28 <- raster("./data/albers/mapbiomas/mapbiomas.none.2012.tif")
area.uso28 <- as.data.frame(uso28) %>%
    group_by(mapbiomas.none.2012) %>%
    tally() %>%
    mutate(area_ha = n * 0.09)
write.csv(area.uso28,"./results/mapbiomas/area-uso-2012.csv", row.names = TRUE)

uso29 <- raster("./data/albers/mapbiomas/mapbiomas.none.2013.tif")
area.uso29 <- as.data.frame(uso29) %>%
    group_by(mapbiomas.none.2013) %>%
    tally() %>%
    mutate(area_ha = n * 0.09)
write.csv(area.uso29,"./results/mapbiomas/area-uso-2013.csv", row.names = TRUE)

uso30 <- raster("./data/albers/mapbiomas/mapbiomas.none.2014.tif")
area.uso30 <- as.data.frame(uso30) %>%
    group_by(mapbiomas.none.2014) %>%
    tally() %>%
    mutate(area_ha = n * 0.09)
write.csv(area.uso30,"./results/mapbiomas/area-uso-2014.csv", row.names = TRUE)

uso31 <- raster("./data/albers/mapbiomas/mapbiomas.none.2015.tif")
area.uso31 <- as.data.frame(uso31) %>%
    group_by(mapbiomas.none.2015) %>%
    tally() %>%
    mutate(area_ha = n * 0.09)
write.csv(area.uso31,"./results/mapbiomas/area-uso-2015.csv", row.names = TRUE)

uso32 <- raster("./data/albers/mapbiomas/mapbiomas.none.2016.tif")
area.uso32 <- as.data.frame(uso32) %>%
    group_by(mapbiomas.none.2016) %>%
    tally() %>%
    mutate(area_ha = n * 0.09)
write.csv(area.uso32,"./results/mapbiomas/area-uso-2016.csv", row.names = TRUE)

uso33 <- raster("./data/albers/mapbiomas/mapbiomas.none.2017.tif")
area.uso33 <- as.data.frame(uso33) %>%
    group_by(mapbiomas.none.2017) %>%
    tally() %>%
    mutate(area_ha = n * 0.09)
write.csv(area.uso33,"./results/mapbiomas/area-uso-2017.csv", row.names = TRUE)

uso34 <- raster("./data/albers/mapbiomas/mapbiomas.none.2018.tif")
area.uso34 <- as.data.frame(uso34) %>%
    group_by(mapbiomas.none.2018) %>%
    tally() %>%
    mutate(area_ha = n * 0.09)
write.csv(area.uso34,"./results/mapbiomas/area-uso-2018.csv", row.names = TRUE)




#######################################################################################

####FOR SEVERAL FILES (LOOP) - ATTENTION - UNFINISHED - NOT WORKING--------------------

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
