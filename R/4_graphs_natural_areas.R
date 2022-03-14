####################################################################
###         GRAPHS FOR NATURAL AREAS OF THE SUBWATERSHED
###
### By: Danielle de Oliveira Moreira
### date: 26/07/2020    updated: 25/09/2021
###################################################################



#Opening table with land cover use codes, only for natural areas
code_natural <- read.csv("./results/mapbiomas-col6/legend_col6_mapbiomas_areasnaturais.csv", encoding="utf-8")

# Opening table with calculated areas
list_table_raw <- list.files("./results/mapbiomas-col6/raw", pattern = ".csv", full.names = T)
# list_table_raw

dados1985 <- read.csv(list_table_raw[1], header = T, sep=",", dec=".", encoding="latin1")
dados2020 <- read.csv(list_table_raw[11], header = T, sep=",", dec=".", encoding="latin1")

library(dplyr)
colnames(dados1985)[2] <- "ID" #change name of column number 2
dados1985_1 <- dplyr::inner_join(dados1985,
                          code_natural[, c("ID", "Class_En")],
                          by = "ID") #join tables, but only Class column
dados1985_2 <- subset(dados1985_1, select = c(Class_En, area_ha))


colnames(dados2020)[2] <- "ID" #change name of column number 2
dados2020_1 <- dplyr::inner_join(dados2020,
                                 code_natural[, c("ID", "Class_En")],
                                 by = "ID") #join tables, but only Class column
dados2020_2 <- subset(dados2020_1, select = c(Class_En, area_ha))

##To add a new column (percentage). I'm dividing the area of each class for the total area of the Doce River watershed (area = 8811339 ha)
#library(dplyr)
dados1985_bhrd <- dados1985_2 %>%
    mutate(Percentage = paste0(round(area_ha/8811339*100, 2)))

dados2020_bhrd <- dados2020_2 %>%
    mutate(Percentage = paste0(round(area_ha/8811339*100, 2)))

#Save the results in txt.
write.csv(dados1985_bhrd,
          "./results/mapbiomas-col6/modified/natural_areas_only/area-uso-1985_bhrd_natural(en).csv",
          row.names = TRUE)

write.csv(dados2020_bhrd,
          "./results/mapbiomas-col6/modified/natural_areas_only/area-uso-2020_bhrd_natural(en).csv",
          row.names = TRUE)

### We need to open the new tables to make the graphs. Somehow, if I do not do it, the axis y becomes weird.

Tbhrd1985 <- read.csv("./results/mapbiomas-col6/modified/natural_areas_only/area-uso-1985_bhrd_natural(en).csv", header = T, sep=",", dec=".", encoding="latin1")

Tbhrd2020 <- read.csv("./results/mapbiomas-col6/modified/natural_areas_only/area-uso-2020_bhrd_natural(en).csv", header = T, sep=",", dec=".", encoding="latin1")

# # One table do not have the same number of classes, so we need to add or delete a new row to make equal graphs.


## To delete a row:
dados1985_bhrd_2 <- Tbhrd1985[-c(3),] #delete mangue
dados2020_bhrd_2 <- Tbhrd2020


## To add a new row:
# man <- data.frame("Mangue", 0, 0)
# names(man) <- c("Class", "area_ha", "Percentage")
#
# #Using rbind() function to insert above observation
# Tbhrd2019 <- rbind(Tbhrd2019, man)


#Joining tables (2985 and 2019)
library(dplyr)
bhrd_natural <- full_join(dados1985_bhrd_2, dados2020_bhrd_2, by = "Class_En")

##Changing NA to zero
# unique(bhrd_natural$Percentage.y)
# bhrd_natural[is.na(bhrd_natural)] <- 0


#------------------------------- MAKING GRAPHS ------------------------------------#

library(ggplot2)
library(tidyr) #to gather function

####### MULTIPLE COLUMNS GRAPHS ############

#---------- For entire watershed Comparing land use and land cover of 1985 and 2019

plotNatural_bhrd <- bhrd_natural %>%
    select(-c(X.x, area_ha.x, X.y, area_ha.y)) %>%
    gather("Type", "Value", -Class_En) %>% # to transform table
    ggplot(aes(Class_En, Value, fill = Type), width=.5) + #width makes a thinner or wider bar
    geom_bar(position = "dodge", stat = "identity", width=.6) +
    # geom_text(aes(label = Value), position = position_dodge(1), vjust = -0.5, size = 2.0) +
    theme_classic() +
    expand_limits(y = 100) +
    scale_y_continuous(breaks=seq(0,100,20)) +
    labs(y = "Area (%)", x = NULL, fill = "Year") +
    theme (plot.title = element_text(size=12),
           # axis.text.x = element_blank(),
           # axis.ticks.x = element_blank(),
           # axis.title.x = element_blank(),
           axis.title.y = element_text(size = 10),
           axis.text.x = element_text(size = 8, angle = 45, hjust = 1),
           axis.text.y = element_text(size = 10),
           legend.position = c(0.5, 0.8),
           legend.direction = "horizontal"
           ) +
    scale_fill_manual(                 # adding colors and change legend labels manually
        values = c("Percentage.x"= "#050505",
                   "Percentage.y" = "#fcba03"),
        labels = c("1985", "2020"))

# for gray color: "#818181"; for black color: "#050505"

# To save the figure
jpeg(file="./figs/graf_uso_areas_naturais2(en).jpeg", height = 10, width = 10, units="cm", res=300)
#png(file="./figs/grafico_bhrd1985-2019(3).png", height = 10, width = 25, unit="cm", res=300)
plotNatural_bhrd
dev.off()
