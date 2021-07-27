####################################################################
###         CALCULATE LAND COVER USE AREA FOR EACH SUBWATERSHED
###
### By: Danielle de Oliveira Moreira
### date: 14/07/2020    updated:
####################################################################


library(raster)
library(rgdal) #carregar shp

####Loading several rasters - mapbiomas 2019
#uso <- raster("./data/raster/mapbiomas_col5_1985_Piracicaba.tif")


data <- list.files("./data/raster", pattern = "mapbiomas_col5", full.names = T)
data
uso <- raster(data[1])
uso

plot(uso)
plot(bhrd_uph, add = TRUE)

#calculating the area of a cell.
##First, identify the name (in "names" of "uso" object) of the column to group_by.
##Now calculate the area
library(dplyr)
area_uso <- as.data.frame(uso) %>%
    group_by(mapbiomas_col5_1985_BaixoDoce) %>%
    tally() %>%
    mutate(area_ha = n * 0.09) #multiplying by 0.09ha or 900m2, area of each cell.

area_uso

#Save the results in txt.
write.csv(area_uso,"./results/mapbiomas_wgs84/raw/area-uso-2019_bhrd-SaoJose.csv",
          row.names = TRUE)


#----------------- MANIPULATING DATA -------------------#
# Manipulating table.
## Join tables to insert information of land cover use

#Opening table with land cover use codes
code <- read.csv2("./results/mapbiomas_wgs84/legend_col5_mapbiomas.csv", encoding="utf-8")

# Opening table with calculated areas
list_table_raw <- list.files("./results/mapbiomas_wgs84/raw", pattern = ".csv", full.names = T)
list_table_raw

tab <- read.csv(list_table_raw[22], header = T, sep=",", dec=".", encoding="utf-8")
tab


#library(dplyr)
colnames(tab)[2] <- "ID" #change name of column number 2
tab2 <- dplyr::inner_join(tab,
                          code[, c("ID", "my_class2")],
                          by = "ID") #join tables, but only my_class column
tab2 <- subset(tab2, select = c(my_class2, area_ha))

##Changing names of table fields
#unique(tab2_1985$my_classes)
#tab2_2019$my_classes[tab2_2019$my_classes == "Area natural"] = "Área natural"
#tab2_2019$my_classes[tab2_2019$my_classes == "Agua"] = "Água"

##To sum areas with same classes (rows) AND add a new column (percentage)
#library(dplyr)
tab2019_bhrd <- tab2 %>%
    group_by(my_class2) %>%
    summarise(area_ha = sum(area_ha)) %>%
    mutate(Percentage = paste0(round(area_ha/sum(area_ha)*100,2)))
    #slice(-c(10)) %>% #to remove row with NA

#Save the results of frequency in txt.
write.csv(tab2019_bhrd,
          "./results/mapbiomas_wgs84/modified/8_classes/area-uso-2019_bhrd3.csv",
          row.names = TRUE)

# I run each file from list_table (between lines 50 and 73, changing the object name on line 66 - to sum areas with same classes). Below are the objects created:
tab1985_BaixoDoce
tab1985_Caratinga
tab1985_Guandu
tab1985_Manhuacu
tab1985_Piracicaba
tab1985_Piranga
tab1985_SantaMariaDoDoce
tab1985_SantoAntonio
tab1985_SaoJose
tab1985_SuacuiGrande
tab1985_bhrd

tab2019_BaixoDoce
tab2019_Caratinga
tab2019_Guandu
tab2019_Manhuacu
tab2019_Piracicaba
tab2019_Piranga
tab2019_SantaMariaDoDoce
tab2019_SantoAntonio
tab2019_SaoJose
tab2019_SuacuiGrande
tab2019_bhrd


## Or we can calculate descriptive statistics, where sum is what we want:
#library(doBy)
#tab4 <- summaryBy(area_ha ~ my_classes, data=tab2, FUN=c(length,sum,mean,sd))
#tab4


#----------------- MAKING GRAPHS -------------------#
##Plot in a graph
### To remove scientific format of numbers
options(scipen = 999)

library(ggplot2)

## without colors
png(file="./figs/grafico_classes1985_bhrd-Manhuacu.png", height=15, width=20, unit="cm", res=300) #to save image
ggplot(tab2019_bhrd, aes(reorder(my_class, -area_ha, sum), area_ha, width=.7)) + #width faz a barra ficar mais fina (ou grossa)
    geom_col() +
    theme_classic() +
    labs(y = "Área (ha)", x = NULL) +
    theme (axis.text = element_text(size = 10), axis.title=element_text(size=10),
           axis.text.x=element_text(size = 10, angle = 45, hjust = 1)) #hjust adjust text below axis x
dev.off()


##The palette colors
palette <- c("#FFD966", "#1F4423", "#0000FF", "#32CD32", "#E974ED", "#935132", "#aa0000", "#FF99FF", "#af2a2a")

png(file="./figs/grafico_classes_bhrd.png", height=15, width=20, unit="cm", res=300) #to save image
ggplot(tab2019_bhrd, aes(reorder(my_class, -area_ha, sum), area_ha, fill = my_classes, width=.7)) + #width faz a barra ficar mais fina (ou grossa)
    geom_col(fill = palette) +
    theme_classic() +
    labs(y = "Área (ha)", x = NULL) +
    theme (axis.text = element_text(size = 10), axis.title=element_text(size=10),
           axis.text.x=element_text(size = 10, angle = 45, hjust = 1)) #hjust adjust text below axis x
dev.off()
