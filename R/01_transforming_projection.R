#####################################################
###     Script para mudar de projecao de varios   ###
###     arquivos rasters ao mesmo tempo.          ###
### Criação: Ana Carolina Devides Castello        ###
<<<<<<< HEAD
### Modificado: Danielle de Oliveira Moreira &    ###
###         Gustavo Varela-Alvarenga              ###
### em 05/05/2020                                 ###
=======
### Modificado: Danielle de Oliveira Moreira      ###
### em 06/04/2020                                 ###
>>>>>>> 75cd6fda662c138437f273a4f41909be93f2f832
#####################################################


library(raster)
<<<<<<< HEAD
library(rgdal)

## Open the raster file
uso2018 <- raster("./data/mapbiomas-none-2018.tif")


## Plot distribution of raster values
hist<-hist(uso2018,
           breaks=3,
           main="Histograma uso e cobertura do solo",
           col="wheat3",  # changes bin color
           xlab= "classes")  # label the x-axis


# Retorna os pontos de corte do histograma
cortes_2018 <- hist$breaks

#plot a map
myCol = terrain.colors(4) #assign the color ramp

plot(uso2018,
     breaks = cortes_2018,
     col = myCol,
     main="2018",
     xlab = "",
     ylab = "")

#######--------------------------Project to Albers--------------------------------#######

##Para um arquivo raster

# Plotar o mapa com as informacoes de projecao encontradas aqui:
# https://spatialreference.org/ref/sr-org/7390/
# Link Proj4: https://spatialreference.org/ref/sr-org/7390/proj4/

## Agora, usando referencia WGS84
## Referencia anterior era: SAD69, nao WGS84

### Codigo abaixo demorou mais de uma hora para rodar. Use nearest neighbor interpolation method (ngb) to ensure that the values stay the same

uso2018_albers_novo_ngb <- projectRaster(
    uso2018,
    crs = CRS("+proj=aea +lat_1=10 +lat_2=-40 +lat_0=-25 +lon_0=-50 +x_0=0 +y_0=0 +ellps=WGS84 +datum=WGS84 +units=m +no_defs"),
    method = "ngb" # NOVA OPCAO PARA MANTER A AREA
)

#Save new file
writeRaster(uso2018_albers_novo_ngb, "./data/albers/mapbiomas.2018.ngb.tif", driver = "ESRI Shapefile", format = 'GTiff', overwrite = T)

uso2018_ngb <- raster("./data/albers/mapbiomas.2018.ngb.tif")


#########----------------PROJECTION ALBERS FOR MORE THAN ONE FILE-----------------#######

# Diretorio onde estao os dados
Dir <- "./data/mapbiomas"
=======

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
>>>>>>> 75cd6fda662c138437f273a4f41909be93f2f832

# Lista dos arquivos
data <- list.files(Dir, pattern = ".tif", full.names = T)

data

# Diretorio onde serao salvos os dados com a resolucao transformada
<<<<<<< HEAD
Dirsave <- "./data/albers/mapbiomas"
dir.create(Dirsave) #para criar a nova pasta
=======
Dirsave <- "./data/albers"
dir.create(Dirsave) #cria a nova pasta
>>>>>>> 75cd6fda662c138437f273a4f41909be93f2f832

#Loop para reprojetar
for (i in 1:length(data)) {
    print(i)
    layer1 <- raster(data[i])
<<<<<<< HEAD
    layer2 <- projectRaster(layer1, crs = CRS("+proj=aea +lat_1=10 +lat_2=-40 +lat_0=-25 +lon_0=-50 +x_0=0 +y_0=0 +ellps=WGS84 +datum=WGS84 +units=m +no_defs"), method = "ngb")
=======
    layer2 <- projectRaster(layer1, crs = CRS("+proj=aea +lat_1=-5 +lat_2=-42 +lat_0=-32 +lon_0=-60 +x_0=0 +y_0=0 +ellps=aust_SA +units=m +no_defs"))
>>>>>>> 75cd6fda662c138437f273a4f41909be93f2f832
    writeRaster(layer2, paste(Dirsave, paste0(names(layer1), '.tif$'), sep = '/'),
                format = 'GTiff',
                overwrite = T)
}
<<<<<<< HEAD
=======

#Loop para definir a projecao
#for (i in 1:length(data)) {
#    print(i)
#    layer <- raster(data[i])
#    crs(layer) <- "+proj=aea +lat_1=-5 +lat_2=-42 +lat_0=-32 +lon_0=-60 +x_0=0 +y_0=0 +ellps=aust_SA +units=m +no_defs "
#    writeRaster(layer, paste(Dirsave, paste0(names(layer), '.tif$'), sep = '/'),
#                format = 'GTiff',
#                overwrite = T)
#}
>>>>>>> 75cd6fda662c138437f273a4f41909be93f2f832
