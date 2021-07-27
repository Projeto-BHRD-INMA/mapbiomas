####################################################################
###         GRAPHS FOR NATURAL AREAS OF THE SUBWATERSHED
###
### By: Danielle de Oliveira Moreira
### date: 26/07/2020    updated:
###################################################################



#Opening table with land cover use codes, only for natural areas
code <- read.csv2("./results/mapbiomas_wgs84/legend_col5_mapbiomas_areasnaturais.csv", encoding="utf-8")

# Opening table with calculated areas
list_table_raw <- list.files("./results/mapbiomas_wgs84/raw", pattern = ".csv", full.names = T)
list_table_raw

dados1985 <- read.csv(list_table_raw[11], header = T, sep=",", dec=".", encoding="utf-8")
dados2019 <- read.csv(list_table_raw[22], header = T, sep=",", dec=".", encoding="utf-8")

library(dplyr)
colnames(dados1985)[2] <- "ID" #change name of column number 2
dados1985_1 <- dplyr::inner_join(dados1985,
                          code[, c("ID", "Class")],
                          by = "ID") #join tables, but only Class column
dados1985_2 <- subset(dados1985_1, select = c(Class, area_ha))


colnames(dados2019)[2] <- "ID" #change name of column number 2
dados2019_1 <- dplyr::inner_join(dados2019,
                                 code[, c("ID", "Class")],
                                 by = "ID") #join tables, but only Class column
dados2019_2 <- subset(dados2019_1, select = c(Class, area_ha))

##To add a new column (percentage). I'm dividing the area of each class for the total area of the Doce River watershed (area = 8808207 ha)
#library(dplyr)
dados1985_bhrd <- dados1985_2 %>%
    mutate(Percentage = paste0(round(area_ha/8808207*100, 2)))

dados2019_bhrd <- dados2019_2 %>%
    mutate(Percentage = paste0(round(area_ha/8808207*100, 2)))

#Save the results in txt.
write.csv(dados1985_bhrd,
          "./results/mapbiomas_wgs84/modified/natural_areas_only/area-uso-1985_bhrd4.csv",
          row.names = TRUE)

write.csv(dados2019_bhrd,
          "./results/mapbiomas_wgs84/modified/natural_areas_only/area-uso-2019_bhrd4.csv",
          row.names = TRUE)

### We need to open the new tables to make the graphs. Somehow, if I do not do it, the axis y becomes weird.

Tbhrd1985 <- read.csv("./results/mapbiomas_wgs84/modified/natural_areas_only/area-uso-1985_bhrd4.csv", header = T, sep=",", dec=".", encoding="utf-8")

Tbhrd2019 <- read.csv("./results/mapbiomas_wgs84/modified/natural_areas_only/area-uso-2019_bhrd4.csv", header = T, sep=",", dec=".", encoding="utf-8")

# # One table do not have the same number of classes, so we need to add or delete a new row to make equal graphs.


## To delete a row:
dados1985_bhrd_2 <- Tbhrd1985[-c(3, 4),]
dados2019_bhrd_2 <- Tbhrd2019[-c(3),]


## To add a new row:
# man <- data.frame("Mangue", 0, 0)
# names(man) <- c("Class", "area_ha", "Percentage")
#
# #Using rbind() function to insert above observation
# Tbhrd2019 <- rbind(Tbhrd2019, man)


#Joining tables (2985 and 2019)
library(dplyr)
bhrd_natural <- full_join(dados1985_bhrd_2, dados2019_bhrd_2, by = "Class")

##Changing NA to zero
# unique(bhrd_natural$Percentage.y)
# bhrd_natural[is.na(bhrd_natural)] <- 0


#------------------------------- MAKING GRAPHS ------------------------------------#

library(ggplot2)
library(tidyr) #for gather function

####### MULTIPLE COLUMNS GRAPHS ############

#---------- For entire watershed Comparing land use and land cover of 1985 and 2019

plotNatural_bhrd <- bhrd_natural %>%
    select(-c(X.x, area_ha.x, X.y, area_ha.y)) %>%
    gather("Type", "Value", -Class) %>% # to transform table
    ggplot(aes(Class, Value, fill = Type), width=.5) + #width makes a thinner or wider bar
    geom_bar(position = "dodge", stat = "identity") +
    geom_text(aes(label = Value), position = position_dodge(1), vjust = -0.5, size = 2.0) +
    theme_classic() +
    expand_limits(y = 100) +
    labs(y = "Área ocupada (%)", x = NULL, fill = "Ano") +
    theme (plot.title = element_text(size=12),
           # axis.text.x = element_blank(),
           # axis.ticks.x = element_blank(),
           # axis.title.x = element_blank(),
           axis.text.x = element_text(size = 10, angle = 45, hjust = 1),
           axis.text.y = element_text(size = 10),
           legend.position = c(0.5, 0.8),
           legend.direction = "horizontal"
           ) +
    scale_fill_manual(                 # adding colors and change legend labels manually
        values = c("Percentage.x"= "#818181",
                   "Percentage.y" = "#050505"),
        labels = c("1985", "2019"))

# To save the figure
jpeg(file="./figs/graf_uso_areas_naturais2.jpeg", height = 10, width = 15, units="cm", res=300)
#png(file="./figs/grafico_bhrd1985-2019(3).png", height = 10, width = 25, unit="cm", res=300)
plotNatural_bhrd
dev.off()
