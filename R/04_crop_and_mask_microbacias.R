##################################################################
## Cortar raster da bacia por microbacias
##
## Por: Danielle de Oliveira Moreira
## Data: 18/05/2020
################################################################


library(raster)
library(rgdal) #carregar shp

#carregar arquivos shp
bhrd_uph <- readOGR(dsn = "./data/albers/microbacias", layer = "bhrd_uph")

#escolher uma microbacia
plot(bhrd_uph)

head(bhrd_uph)

bhrd_uph@data[["uph_nm"]] #para ver os nomes das subdivisoes do shp e escolher a microbacia

bhrd_micro <- subset(bhrd_uph, uph_nm=="MANHUAÃ‡U")

plot(bhrd_uph)
plot(bhrd_micro, col = "blue", border = FALSE, add = TRUE)

#_------------------------CROP RASTER -----------------------------------------------
#Carregar raster

uso2018 <- raster("./data/albers/mapbiomas/mapbiomas.none.2018.tif")

plot(uso2018)
plot(bhrd_uph, border = "black", add = TRUE)
plot(bhrd_micro, border = FALSE, col = "blue", add = TRUE)

## crop and mask
uso2018_crop <- crop(uso2018, extent(bhrd_micro))

# Após o crop
plot(uso2018_crop)
plot(bhrd_uph, add = TRUE)

# Adicionar uma máscara para cortar exatamente nos limites da microbacia
uso2018_micro <- mask(uso2018_crop, bhrd_micro)

## Check that it worked
plot(uso2018_micro)
plot(bhrd_uph, add=TRUE, lwd=2)

# Salvar Raster cortado

writeRaster(uso2018_micro, "./data/albers/mapbiomas/microbacias/mapbiomas.2018.Manhuacu.tif", driver = "ESRI Shapefile", format = 'GTiff', overwrite = T)

uso2018_micro <- raster("./data/albers/mapbiomas/microbacias/mapbiomas.2018.Manhuacu.tif")

plot(uso2018_micro)
plot(bhrd_uph, add=TRUE, lwd=2)

