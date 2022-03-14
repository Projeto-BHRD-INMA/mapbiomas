##################################################################
## Crop a raster using a mask
##
## by: Danielle de Oliveira Moreira
## date:29/06/2021
################################################################

library(raster)
library(rgdal) #load shp

#load shp
bhrd <- readOGR(dsn = "./data/shp", layer = "microbacias_wgs84")


#plot shp
plot(bhrd)

#check coordinate system
crs(bhrd)


#------------------------CROP RASTER -----------------------------------------------
#Load raster

uso1985 <- raster("./data/raster/COLECAO_5_MATAATLANTICA-1985.tif")
uso2019 <- raster("./data/raster/COLECAO_5_MATAATLANTICA-2019.tif")
crs(uso1985) #same coordinate system?
crs(uso2019)

## If needed: reproject shp to same geographic system of raster
#crs(bhrd) <- "+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs"

par(mfrow=c(1,2))
plot(uso1985)
plot(bhrd, border = "black", add = TRUE)
plot(uso2019)
plot(bhrd, border = "black", add = TRUE)
#dev.off()


## crop
#?rgdal
library(rgeos)
uso1985_crop <- crop(uso1985, extent(bhrd))
uso2019_crop <- crop(uso2019, extent(bhrd))


# Mask: Add a mask to cut exactly for the shp limits
uso1985_bhrd <- mask(uso1985_crop, bhrd)
uso2019_bhrd <- mask(uso2019_crop, bhrd)

## Plot Mapbiomas 1985 and Mapbiomas 2019
#png("./figs/uso1985_2019_bhrd.png")
par(mfrow=c(2,1))
plot(uso1985_bhrd)
plot(bhrd, add=TRUE, lwd=2)
plot(uso2019_bhrd)
plot(bhrd, add=TRUE, lwd=2)
dev.off()

# Saving new raster

writeRaster(uso1985_bhrd, "./data/raster/mapbiomas_col5_1985_bhrd.tif", driver = "ESRI Shapefile", format = 'GTiff', overwrite = T)

writeRaster(uso2019_bhrd, "./data/raster/mapbiomas_col5_2019_bhrd.tif", driver = "ESRI Shapefile", format = 'GTiff', overwrite = T)



