# calculating pangenome openness
# Alexa R. Cohn
# 30 March 2021

# install and load required packages
# install.packages("BiocManager")
# BiocManager::install("S4Vectors")
# BiocManager::install("roary_2_pagoo")
# BiocManager::install("Biostrings")
# BiocManager::install("GenomicRanges")
# install.packages("pagoo")
library(pagoo)

# read roary output
roary_output <- "~/Documents/Cerro Host Adaptation/Pangenome/gene_presence_absence_roary.csv"
pg <- roary_2_pagoo(gene_presence_absence_csv = roary_output, sep = ",")

# query data
pg$core_level <- 100
pg$summary_stats
pg$clusters
pg$core_clusters

# calculate pairwise gene abundance distances
pg_dist <- pg$dist()

# principal component analysis
pca <- pg$pan_pca()
summary(pca)

# pangenome plots
# pie
pie1 <- pg$gg_pie() + 
  scale_fill_discrete(guide = guide_legend(keywidth = .75),
                      keyheight = .75)) +
  ggtitle("Pangenome Composition of S. Cerro") +
  theme_bw(base_size = 15) +
  scale_fill_brewer(palette = "Blues") +
  theme(legend.position = 'bottom',
        legend.title = element_blank(),
        legend.margin = margin(0, 0, 13, 0),
        legend.box.margin = margin(0, 0, 5, 0),
        axis.title.x = element_blank(),
        axis.title.y = element_blank(),
        axis.ticks = element_blank(),
        axis.text.x = element_blank())
pie1
# gene frequency bar chart
pg$gg_barplot() +
  theme_bw(base_size = 15) +
  theme(axis.title = element_text(size = 12),
        axis.text = element_text(size = 12)) +
  geom_bar(stat = 'identity', color = 'black', fill = 'black')
# gene presence/absence bin map
pg$gg_binmap()
# rarefaction curves
pg$gg_curves() +
  ggtitle("Pangenome and Coregenome curves") + 
  geom_point() + 
  facet_wrap(~Category, scales = 'free_y') + 
  theme_bw(base_size = 15) + 
  scale_color_brewer(palette = "Accent")

# fit power law function
pg$pg_power_law_fit()

#fit core genome exponential decay function
pg$cg_exp_decay_fit()
