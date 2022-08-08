prophage <- read.csv("~/Documents/Cerro Host Adaptation/boxplot_prophage.csv")

library(tidyverse)

group.colors <- c("#cc6677", "#882255")

SE1 <- subset(prophage, prophage == "SE1", select = c(genome, length, sequencetype))
ggplot(SE1, aes(x=sequencetype, y=length, color=sequencetype)) +
  geom_boxplot() +
  scale_colour_manual(values=group.colors) +
  ylim(c(0,60000)) +
  xlab("sequence type") +
  ylab("phage length (bp)") +
  ggtitle("SE1")

ST160 <- subset(prophage, prophage == "ST160", select = c(genome, length, sequencetype))
ggplot(ST160, aes(x=sequencetype, y=length, color=sequencetype)) +
  geom_boxplot() +
  scale_colour_manual(values=group.colors) +
  xlab("sequence type") +
  ylab("phage length (bp)") +
  ggtitle("ST160")
