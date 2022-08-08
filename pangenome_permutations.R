# Alexa R Cohn
# 10 July 2022
# pangenome permutations

# Load and install packages
# install.packages("pagoo")
# BiocManager::install("S4Vectors")
# BiocManager::install("Biostrings")
# BiocManager::install("GenomicRanges")
library(pagoo)
library(tidyverse)

# read gene presence/absence matrix
cattle_df <- read.csv("~/Documents/Cerro Host Adaptation/Pangenome/gene_presence_absence_cattle.csv")
human_df <- read.csv("~/Documents/Cerro Host Adaptation/Pangenome/gene_presence_absence_human.csv")
environmental_df <- read.csv("~/Documents/Cerro Host Adaptation/Pangenome/gene_presence_absence_environmental.csv")

# create 100 data frames with randomly 15 selected cattle isolates
random_cattle_df <- data.frame()
listofdfs_cattle <- list()
for (i in 1:100) {
  random_cattle_df <- cattle_df[ , sample(15:221, 15)]
  random_cattle_df_bind <- cbind(cattle_df[1:14], random_cattle_df[1:15])
  listofdfs_cattle[[i]] <- random_cattle_df_bind
}

# create 100 data frames with randomly 15 selected human isolates
random_human_df <- data.frame()
listofdfs_human <- list()
for (i in 1:100) {
  random_human_df <- human_df[ , sample(15:40, 15)]
  random_human_df_bind <- cbind(human_df[1:14], random_human_df[1:15])
  listofdfs_human[[i]] <- random_human_df_bind
}

# create 100 data frames with randomly 15 selected environmental isolates
random_environmental_df <- data.frame()
listofdfs_environmental <- list()
for (i in 1:100) {
  random_environmental_df <- environmental_df[ , sample(15:87, 15)]
  random_environmental_df_bind <- cbind(environmental_df[1:14], random_environmental_df[1:15])
  listofdfs_environmental[[i]] <- random_environmental_df_bind
}

# save cattle dataframes as csv files
for (i in 1:100) {
  write.csv(listofdfs_cattle[[i]], paste0("~/Documents/Cerro Host Adaptation/Pangenome/random_cattle_df_bind", i, ".csv"), row.names = FALSE)
}

# save human dataframes as csv files
for (i in 1:100) {
  write.csv(listofdfs_human[[i]], paste0("~/Documents/Cerro Host Adaptation/Pangenome/random_human_df_bind", i, ".csv"), row.names = FALSE)
}

# save environmental dataframes as csv files
for (i in 1:100) {
  write.csv(listofdfs_environmental[[i]], paste0("~/Documents/Cerro Host Adaptation/Pangenome/random_environmental_df_bind", i, ".csv"), row.names = FALSE)
}

# run power law model on 100 gene presence/absence matrices with randomly selected cattle isolates
pg_cattle <- list()
powerlaw_cattle <- list()
for (i in 1:100) {
  pg_cattle[[i]] <- roary_2_pagoo(gene_presence_absence_csv = paste0("~/Documents/Cerro Host Adaptation/Pangenome/random_cattle_df_bind", i, ".csv"), sep = ",")
  powerlaw_cattle[[i]] <- pg_cattle[[i]]$pg_power_law_fit()
}

# run power law model on 100 gene presence/absence matrices with randomly selected human isolates
pg_human <- list()
powerlaw_human <- list()
for (i in 1:100) {
  pg_human[[i]] <- roary_2_pagoo(gene_presence_absence_csv = paste0("~/Documents/Cerro Host Adaptation/Pangenome/random_human_df_bind", i, ".csv"), sep = ",")
  powerlaw_human[[i]] <- pg_human[[i]]$pg_power_law_fit()
}

# run power law model on 100 gene presence/absence matrices with randomly selected environmental isolates
pg_environmental <- list()
powerlaw_environmental <- list()
for (i in 1:100) {
  pg_environmental[[i]] <- roary_2_pagoo(gene_presence_absence_csv = paste0("~/Documents/Cerro Host Adaptation/Pangenome/random_environmental_df_bind", i, ".csv"), sep = ",")
  powerlaw_environmental[[i]] <- pg_environmental[[i]]$pg_power_law_fit()
}

# create vector with alpha values from calculated power law models (cattle isolates)
random_alphas_cattle <- vector()
for (i in 1:100) {
  random_alphas_cattle[[i]] <- attr(powerlaw_cattle[[i]], which = "alpha")
}
hist(random_alphas_cattle)
qqnorm(random_alphas_cattle)
mean_cattle <- mean(random_alphas_cattle)
sd_cattle <- sd(random_alphas_cattle)

# create vector with alpha values from calculated power law models (human isolates)
random_alphas_human <- vector()
for (i in 1:100) {
  random_alphas_human[[i]] <- attr(powerlaw_human[[i]], which = "alpha")
}
hist(random_alphas_human)
qqnorm(random_alphas_human)
mean_human <- mean(random_alphas_human)
sd_human <- sd(random_alphas_human)

# create vector with alpha values from calculated power law models (environmental isolates)
random_alphas_environmental <- vector()
for (i in 1:100) {
  random_alphas_environmental[[i]] <- attr(powerlaw_environmental[[i]], which = "alpha")
}
hist(random_alphas_environmental)
qqnorm(random_alphas_environmental)
mean_environmental <- mean(random_alphas_environmental)
sd_environmental <- sd(random_alphas_environmental)

# create a dataframe containing random alphas
random_alphas_df <- data.frame(random_alphas_cattle, random_alphas_human, random_alphas_environmental)
write.csv(random_alphas_df,"~/Documents/Cerro Host Adaptation/Pangenome/random_alphas_source.csv")
random_alphas_df <- read.csv("~/Documents/Cerro Host Adaptation/Pangenome/random_alphas_source.csv")

# run anova on random alphas
isolationsource_aov <- aov(alpha ~ source, random_alphas_df)
summary(isolationsource_aov)
tukey_aov <- TukeyHSD(isolationsource_aov)
tukey_aov
tukey.plot.aov<-aov(alpha ~ source, data = random_alphas_df)
tukey.plot.test <- TukeyHSD(tukey.plot.aov)
plot(tukey.plot.test, las = 1)

ggplot(data = random_alphas_df, aes(x = source, y = alpha))+
  geom_boxplot(aes(fill = source, show.legend = FALSE))+
  geom_jitter(color="black", size=0.4, alpha=0.9)
