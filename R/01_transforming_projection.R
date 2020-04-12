#####################################################
###     Script para mudar de projecao de varios   ###
###     arquivos rasters ao mesmo tempo.          ###
### Criação: Ana Carolina Devides Castello        ###
### Modificado: Danielle de Oliveira Moreira      ###
### em 06/04/2020                                 ###
#####################################################


library(raster)

#For one raster file
uso <- raster("./data/mapbiomas-none-2018.tif")
uso

plot(uso)

#Project to Albers
uso_albers <- projectRaster(uso, crs = CRS("+proj=aea +lat_1=-5 +lat_2=-42 +lat_0=-32 +lon_0=-60 +x_0=0 +y_0=0 +ellps=aust_SA +units=m +no_defs"))

#Save new file
writeRaster(uso_albers, "./data/albers/mapbiomas.none.1985.tif", driver = "ESRI Shapefile", format = 'GTiff', overwrite = T)

#FOR MORE THAN ONE FILE
# Diretorio onde estao os dados
Dir <- "./data"

# Lista dos arquivos
data <- list.files(Dir, pattern = ".tif", full.names = T)

data

# Diretorio onde serao salvos os dados com a resolucao transformada
Dirsave <- "./data/albers"
dir.create(Dirsave) #cria a nova pasta

#Loop para reprojetar
for (i in 1:length(data)) {
    print(i)
    layer1 <- raster(data[i])
    layer2 <- projectRaster(layer1, crs = CRS("+proj=aea +lat_1=-5 +lat_2=-42 +lat_0=-32 +lon_0=-60 +x_0=0 +y_0=0 +ellps=aust_SA +units=m +no_defs"))
    writeRaster(layer2, paste(Dirsave, paste0(names(layer1), '.tif$'), sep = '/'),
                format = 'GTiff',
                overwrite = T)
}

#Loop para definir a projecao
#for (i in 1:length(data)) {
#    print(i)
#    layer <- raster(data[i])
#    crs(layer) <- "+proj=aea +lat_1=-5 +lat_2=-42 +lat_0=-32 +lon_0=-60 +x_0=0 +y_0=0 +ellps=aust_SA +units=m +no_defs "
#    writeRaster(layer, paste(Dirsave, paste0(names(layer), '.tif$'), sep = '/'),
#                format = 'GTiff',
#                overwrite = T)
#}
