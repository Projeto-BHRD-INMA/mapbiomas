####################################################################
###         VIEW DEFORESTATION AND FOREST REGROWTH IN THE BHRD
###
### By: Danielle de Oliveira Moreira
### date: 30/10/2021    updated: 14/03/2022
####################################################################

# Download data from mapbiomas https://code.earthengine.google.com/?accept_repo=users/mapbiomas/user-toolkit for the Doce River Basin
veg_trans <- read.csv("./data/mapbiomas-col5-bhrd/Deforestation_regeneration/mapbiomas-bhrd-col5-deforest-regener.csv")

names(veg_trans)
unique(veg_trans$band)
unique(veg_trans$class_name)


library(dplyr)

area <- veg_trans %>%
    group_by(band, class_name) %>%
    summarise(area_total = sum(area))


library(ggplot2)

#Cumulativo
line_second <- area %>%
    filter(class_name == "Secondary Vegetation") %>%
    mutate(area_cum = cumsum(area_total)) %>%
    ggplot(aes(x = band, y = area_cum, group = 1)) +
    #geom_bar(stat="identity", fill="blue", alpha=.6) +
    geom_line(stat = "identity") +
    theme_classic() +
    theme(legend.text = element_text(size=11),
          axis.text = element_text(size=10),
          axis.title = element_text(size=11))

line_primary <- area %>%
    filter(class_name == "Primary Vegetation") %>%
    mutate(area_cum = cumsum(area_total)) %>%
    ggplot(aes(x = band, y = area_cum, group = 1)) +
    #geom_bar(stat="identity", fill="blue", alpha=.6) +
    geom_line(stat = "identity") +
    theme_classic() +
    theme(legend.text = element_text(size=11),
          axis.text = element_text(size=10),
          axis.title = element_text(size=11))

line_deforest_primary <- area %>%
    filter(class_name == "Deforestation in  Primary Vegetation") %>%
    mutate(area_cum = cumsum(area_total)) %>%
    ggplot(aes(x = band, y = area_cum, group = 1)) +
    #geom_bar(stat="identity", fill="blue", alpha=.6) +
    geom_line(stat = "identity") +
    theme_classic() +
    theme(legend.text = element_text(size=11),
          axis.text = element_text(size=10),
          axis.title = element_text(size=11))

line_deforest_secondary <- area %>%
    filter(class_name == "Deforestation in  Secondary Vegetation") %>%
    mutate(area_cum = cumsum(area_total)) %>%
    ggplot(aes(x = band, y = area_cum, group = 1)) +
    #geom_bar(stat="identity", fill="blue", alpha=.6) +
    geom_line(stat = "identity") +
    theme_classic() +
    theme(legend.text = element_text(size=11),
          axis.text = element_text(size=10),
          axis.title = element_text(size=11))

line_deforest_regrowth <- area %>%
    filter(class_name == "Secondary Vegetation Regrowth") %>%
    mutate(area_cum = cumsum(area_total)) %>%
    ggplot(aes(x = band, y = area_cum, group = 1)) +
    #geom_bar(stat="identity", fill="blue", alpha=.6) +
    geom_line(stat = "identity") +
    theme_classic() +
    theme(legend.text = element_text(size=11),
          axis.text = element_text(size=10),
          axis.title = element_text(size=11))

