##################################################################
## Cortar raster da bacia por microbacias
##
## Por: Danielle de Oliveira Moreira
## Data: 18/05/2020    update: 13/07/2021
################################################################


library(raster)
library(rgdal) #carregar shp

#Load file shp
bhrd_uph <- readOGR(dsn = "./data/shp", layer = "microbacias_wgs84")

crs(bhrd_uph)

#Reproject shapefile to WGS1984 (if needed)
#bhrd_uph <- spTransform (bhrd_uph, crs("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs"))

#writeOGR(bhrd_uph, "./data/shp", "microbacias_wgs84", driver="ESRI Shapefile", overwrite_layer = TRUE)

#escolher uma microbacia
plot(bhrd_uph)

head(bhrd_uph)
tail(bhrd_uph)

bhrd_uph@data[["uph_cd"]] #para ver os nomes das subdivisoes do shp e escolher a microbacia

bhrd_micro <- subset(bhrd_uph, uph_cd=="507")

plot(bhrd_uph)
plot(bhrd_micro, col = "blue", border = FALSE, add = TRUE)

#_------------------------CROP RASTER -----------------------------------------------
#Carregar raster

uso2019 <- raster("./data/raster/mapbiomas_col5_2019_bhrd.tif")
uso1985 <- raster("./data/raster/mapbiomas_col5_1985_bhrd.tif")

plot(uso1985)
plot(bhrd_uph, border = "black", add = TRUE)
plot(bhrd_micro, border = FALSE, col = "blue", add = TRUE)

## crop and mask
uso2019_crop <- crop(uso2019, extent(bhrd_micro))
uso1985_crop <- crop(uso1985, extent(bhrd_micro))

# Após o crop
plot(uso2019_crop)
plot(bhrd_uph, add = TRUE)

# Adicionar uma máscara para cortar exatamente nos limites da microbacia
uso2019_micro <- mask(uso2019_crop, bhrd_micro)
uso1985_micro <- mask(uso1985_crop, bhrd_micro)

## Check that it worked
plot(uso1985_micro)
plot(bhrd_uph, add=TRUE, lwd=2)

# Salvar Raster cortado

writeRaster(uso2019_micro, "./data/raster/mapbiomas_col5_2019_Guandu.tif",
            driver = "ESRI Shapefile", format = 'GTiff', overwrite = T)

writeRaster(uso1985_micro, "./data/raster/mapbiomas_col5_1985_SaoJose.tif",
            driver = "ESRI Shapefile", format = 'GTiff', overwrite = T)


#---------

uso2019_micro <- raster("./data/raster/mapbiomas_col5_2019_SaoJose.tif")

plot(uso2019_micro)
plot(bhrd_uph, add=TRUE, lwd=2)

