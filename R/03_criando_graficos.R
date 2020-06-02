##
## Criar Gráfico de barras
##
## Por: Danielle de Oliveira Moreira
## Data: 15/05/2020
################################################################


# Carregar o arquivo em csv

area_uso_2018 <- read.csv(file = "./results/mapbiomas/microbacias/area-uso-2018_baixoDoce_mod.csv", sep = ";")

# Ler as primeiras linhas e colunas do arquivo

head(area_uso_2018)

# Trocar os nomes das colunas

names(area_uso_2018) <- c("ID", "Codigo", "Classe", "NPixel", "Area_ha")

# Verificar os novos nomes da tabela
head(area_uso_2018)

area_uso_2018$Classe

## Se tiver uma outra tabela com códigos para juntar: Carregar arquivo de nomes e códigos das classes
#classes <- read.csv(file = "./docs/classes-mapbiomas.csv", sep = ";")
#head(classes)

#names(classes) <- c("Codigo", "Natural.Antropico", "Classes", "Notacao")

# Ler os números do código na tabela classes
#classes$Codigo
#classes$Notacao

# Juntar duas tabelas (classes e area_uso_2018) com a função merge()
#area_classes_2018 <- merge(x = classes,
#                     y = area_uso_2018,
#                     by = "Codigo")

#head(area_classes_2018)

#----------------------------------------------------------------
# Criar um gráfico de barras simples

options(scipen=99) #evita a notação científica

myCol = terrain.colors(4)
barplot(Area_ha ~ Classe, data = area_uso_2018,
        ylab = "Área (ha)",
        col = myCol,
        )

# ou
par(mar = c(4, 4, 4, 4))
with(area_uso_2018, barplot(Area_ha ~ Classe))


# Usando o pacote ggplot2
library(ggplot2)

bar_width <- .7
theme_set(
    theme_classic(base_size = 15)
)

?geom_col
?ggplot2

grafico <- ggplot(area_uso_2018, aes(x = Classe, y = Area_ha)) +
    geom_col(aes(fill = Classe, width = 0.5))

grafico + scale_fill_discrete(name = "Classe", labels = c("AG- Agricultura", "AQ- Água", "FF- Formação Florestal", "FP- Floresta Plantada", "MI- Mineração", "PT- Pastagem", "UR- Área urbana")) + # Edit legend title and labels
    ggtitle("Classes de uso do solo em 2018")

#muda a intensidade da cor
#grafico + scale_fill_hue(l=40, c=35)

# muda manualmente as cores
grafico + scale_fill_manual(values=c("#E974ED", "#0000FF", "#006400", "#32CD32", "#8A2BE2", "#FFD966", "#af2a2a")) +
    theme(legend.title = element_text(size = 40),
          legend.text = element_text(size = 40),
          axis.text=element_text(size = 40, color = "black"),
          axis.title=element_text(size = 44,face = "bold"))


