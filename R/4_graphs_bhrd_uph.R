
####################################################################
###         GRAPHS OF THE DOCE RIVER WATERSHED AND SUBWATERSHED
###
### By: Danielle de Oliveira Moreira
### date: 15/07/2020    updated:
###################################################################


# Opening table with areas calculated
list_table_mod <- list.files("./results/mapbiomas_wgs84/modified/8_classes",
                             pattern = ".csv", full.names = T)
list_table_mod

#For 1985
tab_Carat1985 <- read.csv(list_table_mod[1], header = T, sep=",", dec=".", encoding="utf-8")
tab_Guandu1985 <- read.csv(list_table_mod[2], header = T, sep=",", dec=".", encoding="utf-8")
tab_Manh1985 <- read.csv(list_table_mod[3], header = T, sep=",", dec=".", encoding="utf-8")
tab_Pira1985 <- read.csv(list_table_mod[4], header = T, sep=",", dec=".", encoding="utf-8")
tab_Piran1985 <- read.csv(list_table_mod[5], header = T, sep=",", dec=".", encoding="utf-8")
tab_Santa1985 <- read.csv(list_table_mod[6], header = T, sep=",", dec=".", encoding="utf-8")
tab_SA1985 <- read.csv(list_table_mod[7], header = T, sep=",", dec=".", encoding="utf-8")
tab_SJose1985 <- read.csv(list_table_mod[8], header = T, sep=",", dec=".", encoding="utf-8")
tab_Suacui1985 <- read.csv(list_table_mod[9], header = T, sep=",", dec=".", encoding="utf-8")
tab_BHRD1985 <- read.csv(list_table_mod[10], header = T, sep=",", dec=".", encoding="utf-8")

# Because not all the tables have the same number of classes, let's add for those that are missing to make equivalents graphs
min <- data.frame(8, "Mineração", 0, 0)
names(min) <- c("X", "my_class2", "area_ha", "Percentage")

#Using rbind() function to insert above observation
#tab_BD <- rbind(tab_BD, min)
tab_Carat1985 <- rbind(tab_Carat1985, min)
tab_Manh1985 <- rbind(tab_Manh1985, min)
tab_Suacui1985 <- rbind(tab_Suacui1985, min)
tab_Guandu1985 <- rbind(tab_Guandu1985, min)
tab_Santa1985 <- rbind(tab_Santa1985, min)
tab_SJose1985 <- rbind(tab_SJose1985, min)



#For 2019
tab_Carat2019 <- read.csv(list_table_mod[11], header = T, sep=",", dec=".", encoding="utf-8")
tab_Guandu2019 <- read.csv(list_table_mod[12], header = T, sep=",", dec=".", encoding="utf-8")
tab_Manh2019 <- read.csv(list_table_mod[13], header = T, sep=",", dec=".", encoding="utf-8")
tab_Pira2019 <- read.csv(list_table_mod[14], header = T, sep=",", dec=".", encoding="utf-8")
tab_Piran2019 <- read.csv(list_table_mod[15], header = T, sep=",", dec=".", encoding="utf-8")
tab_Santa2019 <- read.csv(list_table_mod[16], header = T, sep=",", dec=".", encoding="utf-8")
tab_SA2019 <- read.csv(list_table_mod[17], header = T, sep=",", dec=".", encoding="utf-8")
tab_SJose2019 <- read.csv(list_table_mod[18], header = T, sep=",", dec=".", encoding="utf-8")
tab_Suacui2019 <- read.csv(list_table_mod[19], header = T, sep=",", dec=".", encoding="utf-8")
tab_BHRD2019 <- read.csv(list_table_mod[20], header = T, sep=",", dec=".", encoding="utf-8")


# Because not all the tables have the same number of classes, let's add for those that are missing to make equivalents graphs
min <- data.frame(8, "Mineração", 0, 0)
names(min) <- c("X", "my_class2", "area_ha", "Percentage")

#Using rbind() function to insert above observation
#tab_BD <- rbind(tab_BD, min)
tab_Carat2019 <- rbind(tab_Carat2019, min)
tab_Manh2019 <- rbind(tab_Manh2019, min)
tab_Suacui2019 <- rbind(tab_Suacui2019, min)
tab_Guandu2019 <- rbind(tab_Guandu2019, min)
tab_Santa2019 <- rbind(tab_Santa2019, min)
tab_SJose2019 <- rbind(tab_SJose2019, min)


#Joining tables (2985 and 2019)
library(dplyr)
Caratinga <- full_join(tab_Carat1985, tab_Carat2019, by = "my_class2")
Guandu <- full_join(tab_Guandu1985, tab_Guandu2019, by = "my_class2")
Manhuacu <- full_join(tab_Manh1985, tab_Manh2019, by = "my_class2")
Piracicaba <- full_join(tab_Pira1985, tab_Pira2019, by = "my_class2")
Piranga <- full_join(tab_Piran1985, tab_Piran2019, by = "my_class2")
Santa <- full_join(tab_Santa1985, tab_Santa2019, by = "my_class2")
SA <- full_join(tab_SA1985, tab_SA2019, by = "my_class2")
SJose <- full_join(tab_SJose1985, tab_SJose2019, by = "my_class2")
Suacui <- full_join(tab_Suacui1985, tab_Suacui2019, by = "my_class2")
bhrd <- full_join(tab_BHRD1985, tab_BHRD2019, by = "my_class2")




#------------------------------- MAKING GRAPHS ------------------------------------#

## For graphs with more than one column per class - Line 94
## For graphs with one column per class - Line 333


library(ggplot2)


####### MULTIPLE COLUMNS GRAPHS ############

#---------- For entire watershed Comparing land use and land cover of 1985 and 2019

library(tidyr)

plotBhrd <- bhrd %>%
    select(-c(X.x, area_ha.x, X.y, area_ha.y)) %>%
    gather("Type", "Value", -my_class2) %>% # to transform table
    ggplot(aes(my_class2, Value, fill = Type), width=.5) + #width makes a thinner or wider bar
    geom_bar(position = "dodge", stat = "identity") +
    geom_text(aes(label = Value), position = position_dodge(1), vjust = -0.5, size = 2.5) +
    theme_classic() +
    expand_limits(y = 100) +
    labs(y = "Área ocupada (%)", x = NULL, fill = "Ano") +
    theme (plot.title = element_text(size=12),
           # axis.text.x = element_blank(),
           # axis.ticks.x = element_blank(),
           # axis.title.x = element_blank(),
           axis.text.x = element_text(size = 10, angle = 45, hjust = 1),
           legend.position = c(0.5, 0.8),
           legend.direction = "horizontal") +
    scale_fill_manual(                 # adding colors and change legend labels manually
        values = c("Percentage.x"= "#818181",
                   "Percentage.y" = "#050505"),
        labels = c("1985", "2019"))

# To save the figure
jpeg(file="./figs/grafico_uso_bhrd1985-2019(2).jpeg", height = 10, width = 15, units="cm", res=300)
#png(file="./figs/grafico_bhrd1985-2019(3).png", height = 10, width = 25, unit="cm", res=300)
plotBhrd
dev.off()



#---------- For each subwatershed Comparing land use and land cover of 1985 and 2019

plotCaratinga <- Caratinga %>%
    select(-c(X.x, area_ha.x, X.y, area_ha.y)) %>%
    gather("Type", "Value", -my_class2) %>%
    ggplot(aes(my_class2, Value, fill = Type), width=.5) + #width faz a barra ficar mais fina (ou grossa)
    geom_bar(position = "dodge", stat = "identity") +
    # geom_text(aes(label = Value), position = position_dodge(1), vjust = -0.5, size = 2.0) +
    theme_classic() +
    expand_limits(y = 100) +
    ggtitle("Caratinga") +
    labs(y = NULL, x = NULL) +
    theme (plot.title = element_text(size=12),
           axis.text.x = element_blank(),
           # axis.ticks.x = element_blank(),
           # axis.title.x = element_blank(),
           # axis.text.x = element_text(size = 10, angle = 45, hjust = 1),
           legend.position = "none") +
    scale_fill_manual(                 # adding colors manually
        values = c("Percentage.x"= "#818181",
                   "Percentage.y" = "#050505"))


plotGuandu <- Guandu %>%
    select(-c(X.x, area_ha.x, X.y, area_ha.y)) %>%
    gather("Type", "Value", -my_class2) %>%
    ggplot(aes(my_class2, Value, fill = Type), width=.5) + #width faz a barra ficar mais fina (ou grossa)
    geom_bar(position = "dodge", stat = "identity") +
    # geom_text(aes(label = Value), position = position_dodge(1), vjust = -0.5, size = 2.0) +
    theme_classic() +
    expand_limits(y = 100) +
    ggtitle("Guandu") +
    labs(y = "Área ocupada (%)", x = NULL) +
    theme (plot.title = element_text(size=12),
           # axis.text.x = element_blank(),
           # axis.ticks.x = element_blank(),
           # axis.title.x = element_blank(),
           axis.text.x = element_text(size = 10, angle = 45, hjust = 1),
           legend.position = "none") +
    scale_fill_manual(                 # adding colors manually
        values = c("Percentage.x"= "#818181",
                   "Percentage.y" = "#050505"))


plotManhuacu <- Manhuacu %>%
    select(-c(X.x, area_ha.x, X.y, area_ha.y)) %>%
    gather("Type", "Value", -my_class2) %>%
    ggplot(aes(my_class2, Value, fill = Type), width=.5) + #width faz a barra ficar mais fina (ou grossa)
    geom_bar(position = "dodge", stat = "identity") +
    # geom_text(aes(label = Value), position = position_dodge(1), vjust = -0.5, size = 2.0) +
    theme_classic() +
    expand_limits(y = 100) +
    ggtitle("Manhuaçu") +
    labs(y = "Área ocupada (%)", x = NULL) +
    theme (plot.title = element_text(size=12),
           axis.text.x = element_blank(),
           # axis.ticks.x = element_blank(),
           # axis.title.x = element_blank(),
           # axis.text.x = element_text(size = 10, angle = 45, hjust = 1),
           legend.position = "none") +
    scale_fill_manual(                 # adding colors manually
        values = c("Percentage.x"= "#818181",
                   "Percentage.y" = "#050505"))


plotPiracicaba <- Piracicaba %>%
    select(-c(X.x, area_ha.x, X.y, area_ha.y)) %>%
    gather("Type", "Value", -my_class2) %>%
    ggplot(aes(my_class2, Value, fill = Type), width=.5) + #width faz a barra ficar mais fina (ou grossa)
    geom_bar(position = "dodge", stat = "identity") +
    # geom_text(aes(label = Value), position = position_dodge(1), vjust = -0.5, size = 2.0) +
    theme_classic() +
    expand_limits(y = 100) +
    ggtitle("Piracicaba") +
    labs(y = NULL, x = NULL) +
    theme (plot.title = element_text(size=12),
           axis.text.x = element_blank(),
           # axis.ticks.x = element_blank(),
           # axis.title.x = element_blank(),
           # axis.text.x = element_text(size = 10, angle = 45, hjust = 1),
           legend.position = "none") +
    scale_fill_manual(                 # adding colors manually
        values = c("Percentage.x"= "#818181",
                   "Percentage.y" = "#050505"))


plotPiranga <- Piranga %>%
    select(-c(X.x, area_ha.x, X.y, area_ha.y)) %>%
    gather("Type", "Value", -my_class2) %>%
    ggplot(aes(my_class2, Value, fill = Type), width=.5) + #width faz a barra ficar mais fina (ou grossa)
    geom_bar(position = "dodge", stat = "identity") +
    # geom_text(aes(label = Value), position = position_dodge(1), vjust = -0.5, size = 2.0) +
    theme_classic() +
    expand_limits(y = 100) +
    ggtitle("Piranga") +
    labs(y = "Área ocupada (%)", x = NULL, fill = "Ano") +
    theme (plot.title = element_text(size=12),
           axis.text.x = element_blank(),
           # axis.ticks.x = element_blank(),
           # axis.title.x = element_blank(),
           # axis.text.x = element_text(size = 10, angle = 45, hjust = 1),
           legend.position = c(0.5, 0.8),
           legend.direction = "horizontal") + #position of legend inside graph)
    #scale_fill_discrete(name = "Dose", labels = c("A", "B")) +
    scale_fill_manual(                 # adding colors manually
        values = c("Percentage.x"= "#818181",
                   "Percentage.y" = "#050505"),
        labels = c("1985", "2019"))


plotSanta <- Santa %>%
    select(-c(X.x, area_ha.x, X.y, area_ha.y)) %>%
    gather("Type", "Value", -my_class2) %>%
    ggplot(aes(my_class2, Value, fill = Type), width=.5) + #width faz a barra ficar mais fina (ou grossa)
    geom_bar(position = "dodge", stat = "identity") +
    # geom_text(aes(label = Value), position = position_dodge(1), vjust = -0.5, size = 2.0) +
    theme_classic() +
    expand_limits(y = 100) +
    ggtitle("Santa Maria do Doce") +
    labs(y = NULL, x = NULL) +
    theme (plot.title = element_text(size=12),
           # axis.text.x = element_blank(),
           # axis.ticks.x = element_blank(),
           # axis.title.x = element_blank(),
           axis.text.x = element_text(size = 10, angle = 45, hjust = 1),
           legend.position = "none") +
    scale_fill_manual(                 # adding colors manually
        values = c("Percentage.x"= "#818181",
                   "Percentage.y" = "#050505"))

plotSA <- SA %>%
    select(-c(X.x, area_ha.x, X.y, area_ha.y)) %>%
    gather("Type", "Value", -my_class2) %>%
    ggplot(aes(my_class2, Value, fill = Type), width=.5) + #width faz a barra ficar mais fina (ou grossa)
    geom_bar(position = "dodge", stat = "identity") +
    # geom_text(aes(label = Value), position = position_dodge(1), vjust = -0.5, size = 2.0) +
    theme_classic() +
    expand_limits(y = 100) +
    ggtitle("Santo Antônio") +
    labs(y = NULL, x = NULL) +
    theme (plot.title = element_text(size=12),
           axis.text.x = element_blank(),
           # axis.ticks.x = element_blank(),
           # axis.title.x = element_blank(),
           # axis.text.x = element_text(size = 10, angle = 45, hjust = 1),
           legend.position = "none") +
    scale_fill_manual(                 # adding colors manually
        values = c("Percentage.x"= "#818181",
                   "Percentage.y" = "#050505"))


plotSJose <- SJose %>%
    select(-c(X.x, area_ha.x, X.y, area_ha.y)) %>%
    gather("Type", "Value", -my_class2) %>%
    ggplot(aes(my_class2, Value, fill = Type), width=.5) + #width faz a barra ficar mais fina (ou grossa)
    geom_bar(position = "dodge", stat = "identity") +
    # geom_text(aes(label = Value), position = position_dodge(1), vjust = -0.5, size = 2.0) +
    theme_classic() +
    expand_limits(y = 100) +
    ggtitle("São José") +
    labs(y = NULL, x = NULL) +
    theme (plot.title = element_text(size=12),
           # axis.text.x = element_blank(),
           # axis.ticks.x = element_blank(),
           # axis.title.x = element_blank(),
           axis.text.x = element_text(size = 10, angle = 45, hjust = 1),
           legend.position = "none") +
    scale_fill_manual(                 # adding colors manually
        values = c("Percentage.x"= "#818181",
                   "Percentage.y" = "#050505"))


plotSuacui <- Suacui %>%
    select(-c(X.x, area_ha.x, X.y, area_ha.y)) %>%
    gather("Type", "Value", -my_class2) %>%
    ggplot(aes(my_class2, Value, fill = Type), width=.5) + #width faz a barra ficar mais fina (ou grossa)
    geom_bar(position = "dodge", stat = "identity") +
    # geom_text(aes(label = Value), position = position_dodge(1), vjust = -0.5, size = 2.0) +
    theme_classic() +
    expand_limits(y = 100) +
    ggtitle("Suaçuí Grande") +
    labs(y = NULL, x = NULL) +
    theme (plot.title = element_text(size=12),
           axis.text.x = element_blank(),
           # axis.ticks.x = element_blank(),
           # axis.title.x = element_blank(),
           # axis.text.x = element_text(size = 10, angle = 45, hjust = 1),
           legend.position = "none") +
    scale_fill_manual(                 # adding colors manually
        values = c("Percentage.x"= "#818181",
                   "Percentage.y" = "#050505"))


# To save the figure for 1985
library(gridExtra)

jpeg(file="./figs/grafico_uso_uph_1985-2019.jpeg", height = 20, width = 25,
     unit="cm", res=300)
# png(file="./figs/grafico_classes1985_bhrd(3).png", height = 20, width = 25,
#     unit="cm", res=300)
grid.arrange(plotPiranga, plotPiracicaba, plotSA, plotManhuacu, plotCaratinga,
             plotSuacui, plotGuandu, plotSanta, plotSJose, ncol = 3)
dev.off()


######### ONE COLUMN PER CLASS GRAPHS ############

#---------- Comparing land use and land cover of 1985 and 2019

library(ggplot2)

plotBhrd_1985 <- ggplot(tab_BHRD1985, aes(my_class2, Percentage), width=.7) + #width faz a barra ficar mais fina (ou grossa)
    geom_bar(stat = "identity") +
    geom_text(aes(label = Percentage), vjust = -0.5, size = 2.5) +
    theme_classic() +
    expand_limits(y = 100) +
    ggtitle("1985") +
    labs(y = "Área ocupada (%)", x = NULL) +
    theme (plot.title = element_text(size=12),
           # axis.text.x = element_blank(),
           # axis.ticks.x = element_blank(),
           # axis.title.x = element_blank(),
           axis.text.x = element_text(size = 11, angle = 45, hjust = 1),
           # axis.text.y = element_blank(),
           legend.position = "none")

plotBhrd_2019 <- ggplot(tab_BHRD2019, aes(my_class2, Percentage), width=.7) + #width faz a barra ficar mais fina (ou grossa)
    geom_bar(stat = "identity") +
    geom_text(aes(label = Percentage), vjust = -0.5, size = 2.5) +
    theme_classic() +
    expand_limits(y = 100) +
    ggtitle("2019") +
    labs(y = NULL, x = NULL) +
    theme (plot.title = element_text(size=12),
           # axis.text.x = element_blank(),
           # axis.ticks.x = element_blank(),
           # axis.title.x = element_blank(),
           axis.text.x = element_text(size = 11, angle = 45, hjust = 1),
           axis.text.y = element_blank(),
           legend.position = "none")

### The gridExtra package provides the facility to arrage multiple ggplots in a single grid.
library(gridExtra)

# To save the figure
#jpeg(file="./figs/grafico_bhrd1985-2019(2).jpeg", height = 10, width = 25, units="cm", res=300)
png(file="./figs/grafico_bhrd1985-2019(2).png", height = 10, width = 25, unit="cm", res=300)
grid.arrange(plotBhrd_1985, plotBhrd_2019, ncol=2)
dev.off()




#--------------------------- Graphs for subwatershed 1985


plotCarat1985 <- ggplot(tab_Carat1985, aes(my_class2, Percentage), width=.7) + #width faz a barra ficar mais fina (ou grossa)
    geom_bar(stat = "identity") +
    geom_text(aes(label = Percentage), vjust = -0.5, size = 2.5) +
    theme_classic() +
    expand_limits(y = 100) +
    ggtitle("Caratinga") +
    labs(y = NULL, x = NULL) +
    theme (plot.title = element_text(size=12),
           axis.text.x = element_blank(),
           # axis.ticks.x = element_blank(),
           axis.title.x = element_blank(),
           # axis.text.x = element_text(size = 9, angle = 45, hjust = 1),
           axis.text.y = element_blank(),
           legend.position = "none")


plotManh1985 <- ggplot(tab_Manh1985, aes(my_class2, Percentage), width=.7) + #width faz a barra ficar mais fina (ou grossa)
    geom_bar(stat = "identity") +
    geom_text(aes(label = Percentage), vjust = -0.5, size = 2.5) +
    theme_classic() +
    expand_limits(y = 100) +
    ggtitle("Manhuaçu") +
    labs(y = "Área ocupada (%)", x = NULL) +
    theme (plot.title = element_text(size=12),
           axis.text.x = element_blank(),
           # axis.ticks.x = element_blank(),
           axis.title.x = element_blank(),
           # axis.text.x = element_text(size = 9, angle = 45, hjust = 1),
           axis.text.y = element_text(size = 9),
           legend.position = "none")


plotPira1985 <- ggplot(tab_Pira1985, aes(my_class2, Percentage), width=.7) + #width faz a barra ficar mais fina (ou grossa)
    geom_bar(stat = "identity") +
    geom_text(aes(label = Percentage), vjust = -0.5, size = 2.5) +
    theme_classic() +
    expand_limits(y = 100) +
    ggtitle("Piracicaba") +
    labs(y = NULL, x = NULL) +
    theme (plot.title = element_text(size=12),
           axis.text.x = element_blank(),
           # axis.ticks.x = element_blank(),
           axis.title.x = element_blank(),
           # axis.text.x = element_text(size = 9, angle = 45, hjust = 1),
           axis.text.y = element_blank(),
           legend.position = "none")


plotPiran1985 <- ggplot(tab_Piran1985, aes(my_class2, Percentage), width=.7) + #width faz a barra ficar mais fina (ou grossa)
    geom_bar(stat = "identity") +
    geom_text(aes(label = Percentage), vjust = -0.5, size = 2.5) +
    theme_classic() +
    expand_limits(y = 100) +
    ggtitle("Piranga") +
    labs(y = "Área ocupada (%)", x = NULL) +
    theme (plot.title = element_text(size=12),
           axis.text.x = element_blank(),
           # axis.ticks.x = element_blank(),
           axis.title.x = element_blank(),
           # axis.text.x = element_text(size = 9, angle = 45, hjust = 1),
           axis.text.y = element_text(size = 9),
           legend.position = "none")

plotSA1985 <- ggplot(tab_SA1985, aes(my_class2, Percentage), width=.7) + #width faz a barra ficar mais fina (ou grossa)
    geom_bar(stat = "identity") +
    geom_text(aes(label = Percentage), vjust = -0.5, size = 2.5) +
    theme_classic() +
    expand_limits(y = 100) +
    ggtitle("Santo Antônio") +
    labs(y = NULL, x = NULL) +
    theme (plot.title = element_text(size=12),
           axis.text.x = element_blank(),
           # axis.ticks.x = element_blank(),
           axis.title.x = element_blank(),
           # axis.text.x = element_text(size = 9, angle = 45, hjust = 1),
           axis.text.y = element_blank(),
           legend.position = "none")


plotSuacui1985 <- ggplot(tab_Suacui1985, aes(my_class2, Percentage), width=.7) + #width faz a barra ficar mais fina (ou grossa)
    geom_bar(stat = "identity") +
    geom_text(aes(label = Percentage), vjust = -0.5, size = 2.5) +
    theme_classic() +
    expand_limits(y = 100) +
    # scale_fill_manual(values = Palette) +
    ggtitle("Suaçuí Grande") +
    labs(y = NULL, x = NULL) +
    theme (plot.title = element_text(size = 12),
           axis.text.x = element_blank(),
           # axis.ticks.x = element_blank(),
           # axis.title.x = element_blank(),
           # axis.text.x = element_text(size = 11, angle = 45, hjust = 1),
           axis.text.y = element_blank(),
           legend.position = "none")


plotGuandu1985 <- ggplot(tab_Guandu1985, aes(my_class2, Percentage), width=.7) + #width faz a barra ficar mais fina (ou grossa)
    geom_bar(stat = "identity") +
    geom_text(aes(label = Percentage), vjust = -0.5, size = 2.5) +
    theme_classic() +
    expand_limits(y = 100) +
    ggtitle("Guandu") +
    labs(y = "Área ocupada (%)", x = NULL) +
    theme (plot.title = element_text(size=12),
           # axis.text.x = element_blank(),
           # axis.ticks.x = element_blank(),
           # axis.title.x = element_blank(),
           axis.text.x = element_text(size = 11, angle = 45, hjust = 1),
           # axis.text.y = element_blank(),
           legend.position = "none")

plotSanta1985 <- ggplot(tab_Santa1985, aes(my_class2, Percentage), width=.7) + #width faz a barra ficar mais fina (ou grossa)
    geom_bar(stat = "identity") +
    geom_text(aes(label = Percentage), vjust = -0.5, size = 2.5) +
    theme_classic() +
    expand_limits(y = 100) +
    ggtitle("Santa Maria do Doce") +
    labs(y = NULL, x = NULL) +
    theme (plot.title = element_text(size=12),
           # axis.text.x = element_blank(),
           # axis.ticks.x = element_blank(),
           # axis.title.x = element_blank(),
           axis.text.x = element_text(size = 11, angle = 45, hjust = 1),
           axis.text.y = element_blank(),
           legend.position = "none")

plotSJose1985 <- ggplot(tab_SJose1985, aes(my_class2, Percentage), width=.7) + #width faz a barra ficar mais fina (ou grossa)
    geom_bar(stat = "identity") +
    geom_text(aes(label = Percentage), vjust = -0.5, size = 2.5) +
    theme_classic() +
    expand_limits(y = 100) +
    ggtitle("São José") +
    labs(y = NULL, x = NULL) +
    theme (plot.title = element_text(size=12),
           # axis.text.x = element_blank(),
           # axis.ticks.x = element_blank(),
           # axis.title.x = element_blank(),
           axis.text.x = element_text(size = 11, angle = 45, hjust = 1),
           axis.text.y = element_blank(),
           legend.position = "none")


# To save the figure for 1985
jpeg(file="./figs/grafico_classes1985_bhrd(2).jpeg", height = 20, width = 25,
     unit="cm", res=300)
# png(file="./figs/grafico_classes1985_bhrd(2).png", height = 20, width = 25,
#     unit="cm", res=300)
grid.arrange(plotPiran1985, plotPira1985, plotSA1985, plotManh1985, plotCarat1985,
             plotSuacui1985, plotGuandu1985, plotSanta1985, plotSJose1985, ncol = 3)
dev.off()





#--------------------------- Graphs for planning units 2019


plotCarat2019 <- ggplot(tab_Carat2019, aes(my_class2, Percentage), width=.7) + #width faz a barra ficar mais fina (ou grossa)
    geom_bar(stat = "identity") +
    geom_text(aes(label = Percentage), vjust = -0.5, size = 2.5) +
    theme_classic() +
    expand_limits(y = 100) +
    ggtitle("Caratinga") +
    labs(y = NULL, x = NULL) +
    theme (plot.title = element_text(size=12),
           axis.text.x = element_blank(),
           # axis.ticks.x = element_blank(),
           axis.title.x = element_blank(),
           # axis.text.x = element_text(size = 9, angle = 45, hjust = 1),
           axis.text.y = element_blank(),
           legend.position = "none")


plotManh2019 <- ggplot(tab_Manh2019, aes(my_class2, Percentage), width=.7) + #width faz a barra ficar mais fina (ou grossa)
    geom_bar(stat = "identity") +
    geom_text(aes(label = Percentage), vjust = -0.5, size = 2.5) +
    theme_classic() +
    expand_limits(y = 100) +
    ggtitle("Manhuaçu") +
    labs(y = "Área ocupada (%)", x = NULL) +
    theme (plot.title = element_text(size=12),
           axis.text.x = element_blank(),
           # axis.ticks.x = element_blank(),
           axis.title.x = element_blank(),
           # axis.text.x = element_text(size = 9, angle = 45, hjust = 1),
           axis.text.y = element_text(size = 9),
           legend.position = "none")


plotPira2019 <- ggplot(tab_Pira2019, aes(my_class2, Percentage), width=.7) + #width faz a barra ficar mais fina (ou grossa)
    geom_bar(stat = "identity") +
    geom_text(aes(label = Percentage), vjust = -0.5, size = 2.5) +
    theme_classic() +
    expand_limits(y = 100) +
    ggtitle("Piracicaba") +
    labs(y = NULL, x = NULL) +
    theme (plot.title = element_text(size=12),
           axis.text.x = element_blank(),
           # axis.ticks.x = element_blank(),
           axis.title.x = element_blank(),
           # axis.text.x = element_text(size = 9, angle = 45, hjust = 1),
           axis.text.y = element_blank(),
           legend.position = "none")


plotPiran2019 <- ggplot(tab_Piran2019, aes(my_class2, Percentage), width=.7) + #width faz a barra ficar mais fina (ou grossa)
    geom_bar(stat = "identity") +
    geom_text(aes(label = Percentage), vjust = -0.5, size = 2.5) +
    theme_classic() +
    expand_limits(y = 100) +
    ggtitle("Piranga") +
    labs(y = "Área ocupada (%)", x = NULL) +
    theme (plot.title = element_text(size=12),
           axis.text.x = element_blank(),
           # axis.ticks.x = element_blank(),
           axis.title.x = element_blank(),
           # axis.text.x = element_text(size = 9, angle = 45, hjust = 1),
           axis.text.y = element_text(size = 9),
           legend.position = "none")

plotSA2019 <- ggplot(tab_SA2019, aes(my_class2, Percentage), width=.7) + #width faz a barra ficar mais fina (ou grossa)
    geom_bar(stat = "identity") +
    geom_text(aes(label = Percentage), vjust = -0.5, size = 2.5) +
    theme_classic() +
    expand_limits(y = 100) +
    ggtitle("Santo Antônio") +
    labs(y = NULL, x = NULL) +
    theme (plot.title = element_text(size=12),
           axis.text.x = element_blank(),
           # axis.ticks.x = element_blank(),
           axis.title.x = element_blank(),
           # axis.text.x = element_text(size = 9, angle = 45, hjust = 1),
           axis.text.y = element_blank(),
           legend.position = "none")


plotSuacui2019 <- ggplot(tab_Suacui2019, aes(my_class2, Percentage), width=.7) + #width faz a barra ficar mais fina (ou grossa)
    geom_bar(stat = "identity") +
    geom_text(aes(label = Percentage), vjust = -0.5, size = 2.5) +
    theme_classic() +
    expand_limits(y = 100) +
    # scale_fill_manual(values = Palette) +
    ggtitle("Suaçuí Grande") +
    labs(y = NULL, x = NULL) +
    theme (plot.title = element_text(size = 12),
           axis.text.x = element_blank(),
           # axis.ticks.x = element_blank(),
           # axis.title.x = element_blank(),
           # axis.text.x = element_text(size = 11, angle = 45, hjust = 1),
           axis.text.y = element_blank(),
           legend.position = "none")


plotGuandu2019 <- ggplot(tab_Guandu2019, aes(my_class2, Percentage), width=.7) + #width faz a barra ficar mais fina (ou grossa)
    geom_bar(stat = "identity") +
    geom_text(aes(label = Percentage), vjust = -0.5, size = 2.5) +
    theme_classic() +
    expand_limits(y = 100) +
    ggtitle("Guandu") +
    labs(y = "Área ocupada (%)", x = NULL) +
    theme (plot.title = element_text(size=12),
           # axis.text.x = element_blank(),
           # axis.ticks.x = element_blank(),
           # axis.title.x = element_blank(),
           axis.text.x = element_text(size = 11, angle = 45, hjust = 1),
           # axis.text.y = element_blank(),
           legend.position = "none")

plotSanta2019 <- ggplot(tab_Santa2019, aes(my_class2, Percentage), width=.7) + #width faz a barra ficar mais fina (ou grossa)
    geom_bar(stat = "identity") +
    geom_text(aes(label = Percentage), vjust = -0.5, size = 2.5) +
    theme_classic() +
    expand_limits(y = 100) +
    ggtitle("Santa Maria do Doce") +
    labs(y = NULL, x = NULL) +
    theme (plot.title = element_text(size=12),
           # axis.text.x = element_blank(),
           # axis.ticks.x = element_blank(),
           # axis.title.x = element_blank(),
           axis.text.x = element_text(size = 11, angle = 45, hjust = 1),
           axis.text.y = element_blank(),
           legend.position = "none")

plotSJose2019 <- ggplot(tab_SJose2019, aes(my_class2, Percentage), width=.7) + #width faz a barra ficar mais fina (ou grossa)
    geom_bar(stat = "identity") +
    geom_text(aes(label = Percentage), vjust = -0.5, size = 2.5) +
    theme_classic() +
    expand_limits(y = 100) +
    ggtitle("São José") +
    labs(y = NULL, x = NULL) +
    theme (plot.title = element_text(size=12),
           # axis.text.x = element_blank(),
           # axis.ticks.x = element_blank(),
           # axis.title.x = element_blank(),
           axis.text.x = element_text(size = 11, angle = 45, hjust = 1),
           axis.text.y = element_blank(),
           legend.position = "none")

# To save the figure for 2019
# jpeg(file="./figs/grafico_classes2019_bhrd(2).jpeg", height = 20, width = 25,
#      unit="cm", res=300)
png(file="./figs/grafico_classes2019_bhrd(2).png", height = 20, width = 25,
    unit="cm", res=300)
grid.arrange(plotPiran2019, plotPira2019, plotSA2019, plotManh2019, plotCarat2019,
             plotSuacui2019, plotGuandu2019, plotSanta2019, plotSJose2019, ncol = 3)
dev.off()

