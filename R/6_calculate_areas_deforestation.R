####################################################################
###         VIEW DEFORESTATION AND FOREST REGROWTH IN THE BHRD
###
### By: Danielle de Oliveira Moreira
### date: 30/10/2021    updated: 16/03/2022
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

area$band[area$band == "classification_1988"] <- "1988"
area$band[area$band == "classification_1989"] <- "1989"
area$band[area$band == "classification_1990"] <- "1990"
area$band[area$band == "classification_1991"] <- "1991"
area$band[area$band == "classification_1992"] <- "1992"
area$band[area$band == "classification_1993"] <- "1993"
area$band[area$band == "classification_1994"] <- "1994"
area$band[area$band == "classification_1995"] <- "1995"
area$band[area$band == "classification_1996"] <- "1996"
area$band[area$band == "classification_1997"] <- "1997"
area$band[area$band == "classification_1998"] <- "1998"
area$band[area$band == "classification_1999"] <- "1999"
area$band[area$band == "classification_2000"] <- "2000"
area$band[area$band == "classification_2001"] <- "2001"
area$band[area$band == "classification_2002"] <- "2002"
area$band[area$band == "classification_2003"] <- "2003"
area$band[area$band == "classification_2004"] <- "2004"
area$band[area$band == "classification_2005"] <- "2005"
area$band[area$band == "classification_2006"] <- "2006"
area$band[area$band == "classification_2007"] <- "2007"
area$band[area$band == "classification_2008"] <- "2008"
area$band[area$band == "classification_2009"] <- "2009"
area$band[area$band == "classification_2010"] <- "2010"
area$band[area$band == "classification_2011"] <- "2011"
area$band[area$band == "classification_2012"] <- "2012"
area$band[area$band == "classification_2013"] <- "2013"
area$band[area$band == "classification_2014"] <- "2014"
area$band[area$band == "classification_2015"] <- "2015"
area$band[area$band == "classification_2016"] <- "2016"
area$band[area$band == "classification_2017"] <- "2017"

#Making graphs
library(ggplot2)

#Cover area for primary and secondary vegetation
area_cover <- area %>%
    filter(class_name %in% c("Primary Vegetation", "Secondary Vegetation"))

area_cover$band = as.numeric(as.character(area_cover$band))

c <- ggplot(area_cover, aes(x = band, y = area_total,
                       group = class_name)) +
    geom_line(aes(linetype = class_name, color = class_name)) +
    #geom_line() +
    #scale_linetype_manual(values=c("twodash", "dotted")) +
    theme_classic(base_size = 9) +
    theme(#legend.text = element_text(size=8),
        #axis.text = element_text(size=9),
        #axis.title = element_text(size=10),
        #legend.position = c(0.8, 0.4),
        legend.position = "top",
        legend.title = element_blank()) +
    # ylim(0,30000) +
    # xlim(1988, 2020) +
    labs(y = "Total area (km²)",
         x = "Years",
         # color - change legend title
         #color = "Vegetation"
         )


#Deforest area for primary and secondary vegetation
area_deforest <- area %>%
    filter(class_name %in% c("Deforestation in  Primary Vegetation", "Deforestation in  Secondary Vegetation"))

area_deforest$band = as.numeric(as.character(area_deforest$band))

d <- ggplot(area_deforest, aes(x = band, y = area_total,
                               group = class_name,
                               color = class_name)) +
    geom_line(aes(linetype = class_name, color = class_name)) +
    #geom_line() +
    #scale_linetype_manual(values=c("twodash", "dotted")) +
    theme_classic(base_size = 9) +
    theme(#legend.text = element_text(size=8),
        #axis.text = element_text(size=9),
        #axis.title = element_text(size=10),
        legend.position = c(0.6, 0.8),
        #legend.position = "top",
        legend.title = element_blank()) +
    # ylim(0,30000) +
    # xlim(1988, 2020) +
    labs(y = "Total area (km²)",
         x = "Years",
         # color - change legend title
         #color = "Vegetation"
    )


#Proportion of area of primary and secondary vegetation

library(tidyr)

area2 <- area %>%
    filter(!(class_name %in% c("Anthropic", "Not applied"))) %>%
    #filter(!c(Anthropic,Not applied)) %>%
    pivot_wider(names_from = class_name, values_from=area_total)

colnames(area2) <- c("Year", "Defor_Primary", "Primary", "Secondary", "Secondary_regrowth", "Defor_Secondary")

area3 <- area2 %>%
    mutate(prop_d_primary = Defor_Primary/Primary) %>%
    mutate(prop_d_secondary = Defor_Secondary/Secondary) %>%
    mutate(prop_total = (Defor_Primary+Defor_Secondary)/(Primary+Secondary))

p <- area3 %>%
    pivot_longer(!Year, names_to = "Vegetation", values_to = "Area") %>%
    mutate(Year = as.numeric(as.character(Year))) %>%
    filter(Vegetation %in% c("prop_d_primary", "prop_d_secondary", "prop_total")) %>%
    ggplot(., aes(x = Year, y = Area,
                  group = Vegetation,
                  color = Vegetation)) +
    geom_line(aes(linetype = Vegetation, color = Vegetation)) +
    #geom_line() +
    #scale_linetype_manual(values=c("twodash", "dotted")) +
    theme_classic(base_size = 10) +
    theme(#legend.text = element_text(size=8),
        #axis.text = element_text(size=9),
        #axis.text.x = element_text(angle=45),
        #axis.title = element_text(size=10),
        #legend.position = c(0.8, 0.4),
        legend.position = "top",
        legend.title = element_blank()) +
    # ylim(0,30000) +
    # xlim(1988, 2020) +
    labs(y = "Area Proportion",
         x = "Years",
         # color - change legend title
         #color = "Vegetation"
    )

# Saving figures ------------------------------------------------------------------
#Vegetation cover
#jpeg(file="./figs/mapbiomas-col5/vegetation_area_years2.jpeg", height = 8, width = 8.5, unit="cm", res=300)
tiff(file="./figs/mapbiomas-col5/vegetation_area_years.tif", height = 8, width = 8.5, unit="cm", res=300)
c
dev.off()

#Deforestation
#jpeg(file="./figs/mapbiomas-col5/deforest_years.jpeg", height = 8, width = 8.5, unit="cm", res=300)
tiff(file="./figs/mapbiomas-col5/deforest_area_years.tif", height = 8, width = 8.5, unit="cm", res=300)
d
dev.off()

#In svg file
ggsave(file = "./figs/mapbiomas-col5/vegetation_cover.svg", plot = c, width = 8, height = 8.5)

ggsave(file = "./figs/mapbiomas-col5/deforestation_area.svg", plot = d, width = 8, height = 8.5)

#install.packages("cowplot")
library(cowplot)

plot_grid(c, d, f, ncol = 1)

plot_grid(c+theme(legend.position="none"),
          f,
          d+theme(legend.position="none"),
          ncol = 1,
          align = "h")

plot_grid(
    d+theme(legend.position="none"),
    c+theme(legend.position="none"),
    f+theme(legend.position="none"),
    get_legend(c),
    ncol=4,
    rel_width=c(1,1,1,.3))

#----------------------------------------------

#Graph with other format
t <- ggplot(area_cover, aes(x = band, y = area_total,
                            group = class_name, color = class_name)) +
    geom_line(stat = "identity") +
    theme_classic(base_size = 10) +
    theme(#legend.text = element_text(size=8),
        #axis.text = element_text(size=9),
        #axis.title = element_text(size=10),
        #legend.position = c(0.8, 0.4),
        #legend.direction = "vertical",
        legend.position = "top") +
    ylim(0,30000) +
    xlim(1988, 2020) +
    labs(y = "Total area (km²)",
         x = "Years",
         color = "Vegetation") + # color - change legend title
    scale_color_hue(labels = c("Primary", "Secondary"))

