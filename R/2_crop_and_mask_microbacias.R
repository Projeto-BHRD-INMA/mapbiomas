##################################################################
## Clip raster by watershed
##
## Por: Danielle de Oliveira Moreira
## Data: 18/05/2020    update: 24/09/2021
################################################################


library(raster)
library(rgdal) #carregar shp

#Load file shp
bhrd_uph <- readOGR(dsn = "./data/shp", layer = "microbacias_wgs84")

crs(bhrd_uph)

#Reproject shapefile to WGS1984 (if needed)
#bhrd_uph <- spTransform (bhrd_uph, crs("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs"))

#writeOGR(bhrd_uph, "./data/shp", "microbacias_wgs84", driver="ESRI Shapefile", overwrite_layer = TRUE)

#choose a subwatershed
plot(bhrd_uph)

head(bhrd_uph)
tail(bhrd_uph)

bhrd_uph@data[["uph_cd"]] #to check the codes of subdivisions of shp and choose a watershed

bhrd_micro_piranga <- subset(bhrd_uph, uph_cd=="501")
bhrd_micro_piracicaba <- subset(bhrd_uph, uph_cd=="502")
bhrd_micro_santonio <- subset(bhrd_uph, uph_cd=="503")
bhrd_micro_suacui <- subset(bhrd_uph, uph_cd=="504")
bhrd_micro_caratinga <- subset(bhrd_uph, uph_cd=="505")
bhrd_micro_manhuacu <- subset(bhrd_uph, uph_cd=="506")
bhrd_micro_sjose <- subset(bhrd_uph, uph_cd=="507")
bhrd_micro_guandu <- subset(bhrd_uph, uph_cd=="508")
bhrd_micro_smaria <- subset(bhrd_uph, uph_cd=="509")

#check
plot(bhrd_uph)
plot(bhrd_micro_smaria, col = "blue", border = FALSE, add = TRUE)

#------------------------ CROP RASTERS ---------------------------------------------
#Carregar raster

uso2020 <- raster("./data/mapbiomas-col6-bhrd/raster/2020/coverage-2020.tif")
uso1985 <- raster("./data/mapbiomas-col6-bhrd/raster/1985/coverage-1985.tif")

plot(uso1985)
plot(bhrd_uph, border = "black", add = TRUE)
plot(bhrd_micro_piranga, border = FALSE, col = "blue", add = TRUE)

#### crop and mask
#Piranga
uso2020_piranga_crop <- crop(uso2020, extent(bhrd_micro_piranga))
uso1985_piranga_crop <- crop(uso1985, extent(bhrd_micro_piranga))

#Piracicaba
uso2020_piracicaba_crop <- crop(uso2020, extent(bhrd_micro_piracicaba))
uso1985_piracicaba_crop <- crop(uso1985, extent(bhrd_micro_piracicaba))

#Santo Antonio
uso2020_santonio_crop <- crop(uso2020, extent(bhrd_micro_santonio))
uso1985_santonio_crop <- crop(uso1985, extent(bhrd_micro_santonio))

#Suacui Grande
uso2020_suacui_crop <- crop(uso2020, extent(bhrd_micro_suacui))
uso1985_suacui_crop <- crop(uso1985, extent(bhrd_micro_suacui))

#Caratinga
uso2020_caratinga_crop <- crop(uso2020, extent(bhrd_micro_caratinga))
uso1985_caratinga_crop <- crop(uso1985, extent(bhrd_micro_caratinga))

#Manhuacu
uso2020_manhuacu_crop <- crop(uso2020, extent(bhrd_micro_manhuacu))
uso1985_manhuacu_crop <- crop(uso1985, extent(bhrd_micro_manhuacu))

#Sao Jose
uso2020_sjose_crop <- crop(uso2020, extent(bhrd_micro_sjose))
uso1985_sjose_crop <- crop(uso1985, extent(bhrd_micro_sjose))

#Guandu
uso2020_guandu_crop <- crop(uso2020, extent(bhrd_micro_guandu))
uso1985_guandu_crop <- crop(uso1985, extent(bhrd_micro_guandu))

#Santa Maria do Doce
uso2020_smaria_crop <- crop(uso2020, extent(bhrd_micro_smaria))
uso1985_smaria_crop <- crop(uso1985, extent(bhrd_micro_smaria))


# Check after Crop
plot(uso2020_piracicaba_crop)
plot(bhrd_uph, add = TRUE)


### Adding a mask to cut exactly the limits of the watershed
#Piranga
uso2020_piranga_micro <- mask(uso2020_piranga_crop, bhrd_micro_piranga)
uso1985_piranga_micro <- mask(uso1985_piranga_crop, bhrd_micro_piranga)

#Piracicaba
uso2020_piracicaba_micro <- mask(uso2020_piracicaba_crop, bhrd_micro_piracicaba)
uso1985_piracicaba_micro <- mask(uso1985_piracicaba_crop, bhrd_micro_piracicaba)

#Santo Antonio
uso2020_santonio_micro <- mask(uso2020_santonio_crop, bhrd_micro_santonio)
uso1985_santonio_micro <- mask(uso1985_santonio_crop, bhrd_micro_santonio)

#Suacui Grande
uso2020_suacui_micro <- mask(uso2020_suacui_crop, bhrd_micro_suacui)
uso1985_suacui_micro <- mask(uso1985_suacui_crop, bhrd_micro_suacui)

#Caratinga
uso2020_caratinga_micro <- mask(uso2020_caratinga_crop, bhrd_micro_caratinga)
uso1985_caratinga_micro <- mask(uso1985_caratinga_crop, bhrd_micro_caratinga)

#Manhuacu
uso2020_manhuacu_micro <- mask(uso2020_manhuacu_crop, bhrd_micro_manhuacu)
uso1985_manhuacu_micro <- mask(uso1985_manhuacu_crop, bhrd_micro_manhuacu)

#Sao Jose
uso2020_sjose_micro <- mask(uso2020_sjose_crop, bhrd_micro_sjose)
uso1985_sjose_micro <- mask(uso1985_sjose_crop, bhrd_micro_sjose)

#Guandu
uso2020_guandu_micro <- mask(uso2020_guandu_crop, bhrd_micro_guandu)
uso1985_guandu_micro <- mask(uso1985_guandu_crop, bhrd_micro_guandu)

#Santa Maria do Doce
uso2020_smaria_micro <- mask(uso2020_smaria_crop, bhrd_micro_smaria)
uso1985_smaria_micro <- mask(uso1985_smaria_crop, bhrd_micro_smaria)

## Check it
plot(uso1985_piranga_micro)
plot(bhrd_uph, add=TRUE, lwd=2)
dev.off()


## SAVING CLIPPED RASTER -----------------------------------------------------

#Piranga
writeRaster(uso2020_piranga_micro,
            "./data/mapbiomas-col6-bhrd/raster/2020/uph/coverage-2020_Piranga.tif",
            driver = "ESRI Shapefile", format = 'GTiff', overwrite = T)

writeRaster(uso1985_piranga_micro,
            "./data/mapbiomas-col6-bhrd/raster/1985/uph/coverage-1985_Piranga.tif",
            driver = "ESRI Shapefile", format = 'GTiff', overwrite = T)

#Piracicaba
writeRaster(uso2020_piracicaba_micro,
            "./data/mapbiomas-col6-bhrd/raster/2020/uph/coverage-2020_Piracicaba.tif", driver = "ESRI Shapefile", format = 'GTiff', overwrite = T)

writeRaster(uso1985_piracicaba_micro,
            "./data/mapbiomas-col6-bhrd/raster/1985/uph/coverage-1985_Piracicaba.tif", driver = "ESRI Shapefile", format = 'GTiff', overwrite = T)

#Santo Antonio
writeRaster(uso2020_santonio_micro,
            "./data/mapbiomas-col6-bhrd/raster/2020/uph/coverage-2020_SAntonio.tif",
            driver = "ESRI Shapefile", format = 'GTiff', overwrite = T)

writeRaster(uso1985_santonio_micro,
            "./data/mapbiomas-col6-bhrd/raster/1985/uph/coverage-1985_SAntonio.tif",
            driver = "ESRI Shapefile", format = 'GTiff', overwrite = T)

#Suacui Grande
writeRaster(uso2020_suacui_micro,
            "./data/mapbiomas-col6-bhrd/raster/2020/uph/coverage-2020_SuacuiGrande.tif",
            driver = "ESRI Shapefile", format = 'GTiff', overwrite = T)

writeRaster(uso1985_suacui_micro,
            "./data/mapbiomas-col6-bhrd/raster/1985/uph/coverage-1985_SuacuiGrande.tif",
            driver = "ESRI Shapefile", format = 'GTiff', overwrite = T)

#Caratinga
writeRaster(uso2020_caratinga_micro,
            "./data/mapbiomas-col6-bhrd/raster/2020/uph/coverage-2020_Caratinga.tif",
            driver = "ESRI Shapefile", format = 'GTiff', overwrite = T)

writeRaster(uso1985_caratinga_micro,
            "./data/mapbiomas-col6-bhrd/raster/1985/uph/coverage-1985_Caratinga.tif",
            driver = "ESRI Shapefile", format = 'GTiff', overwrite = T)

#Manhuacu
writeRaster(uso2020_manhuacu_micro,
            "./data/mapbiomas-col6-bhrd/raster/2020/uph/coverage-2020_Manhuacu.tif",
            driver = "ESRI Shapefile", format = 'GTiff', overwrite = T)

writeRaster(uso1985_manhuacu_micro,
            "./data/mapbiomas-col6-bhrd/raster/1985/uph/coverage-1985_Manhuacu.tif",
            driver = "ESRI Shapefile", format = 'GTiff', overwrite = T)

#Sao Jose
writeRaster(uso2020_sjose_micro,
            "./data/mapbiomas-col6-bhrd/raster/2020/uph/coverage-2020_SJose.tif",
            driver = "ESRI Shapefile", format = 'GTiff', overwrite = T)

writeRaster(uso1985_sjose_micro,
            "./data/mapbiomas-col6-bhrd/raster/1985/uph/coverage-1985_Sjose.tif",
            driver = "ESRI Shapefile", format = 'GTiff', overwrite = T)

#Guandu
writeRaster(uso2020_guandu_micro,
            "./data/mapbiomas-col6-bhrd/raster/2020/uph/coverage-2020_Guandu.tif",
            driver = "ESRI Shapefile", format = 'GTiff', overwrite = T)

writeRaster(uso1985_guandu_micro,
            "./data/mapbiomas-col6-bhrd/raster/1985/uph/coverage-1985_Guandu.tif",
            driver = "ESRI Shapefile", format = 'GTiff', overwrite = T)

#Santa Maria do Doce
writeRaster(uso2020_smaria_micro,
            "./data/mapbiomas-col6-bhrd/raster/2020/uph/coverage-2020_SMariaDoDoce.tif",
            driver = "ESRI Shapefile", format = 'GTiff', overwrite = T)

writeRaster(uso1985_smaria_micro,
            "./data/mapbiomas-col6-bhrd/raster/1985/uph/coverage-1985_SMariaDoDoce.tif",
            driver = "ESRI Shapefile", format = 'GTiff', overwrite = T)

#---------
#Check
uso1985_smaria_micro <- raster(
    "./data/mapbiomas-col6-bhrd/raster/1985/uph/coverage-1985_SMariaDoDoce.tif")

plot(uso1985_smaria_micro)
plot(bhrd_uph, add=TRUE, lwd=2)

