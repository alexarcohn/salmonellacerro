### pseudogene data
### Alexa R Cohn
### 17 Mar 2021

#tidying 

library(tidyverse)

isolation_source <- read.csv("~/Documents/Cerro Host Adaptation/isolates_forR.csv")
counts <- read.csv("~/Documents/Cerro Host Adaptation/pseudogenes_counts.csv")

combined <- merge(counts, isolation_source, by = "Run.Number")

human <- subset(combined, Type == "Human",
                select = c(Run.Number, locustag, annotation, location, Type))
cattle <- subset(combined, Type == "Cattle",
                 select = c(Run.Number, locustag, annotation, location, Type))
environmental <- subset(combined, Type == "Environment",
                        select = c(Run.Number, locustag, annotation, location, Type))

human$annotation <- as.character(human$annotation)
human$count <- as.numeric(ave(human$annotation, human$annotation, FUN = length))

cattle$annotation <- as.character(cattle$annotation)
cattle$count <- as.numeric(ave(cattle$annotation, cattle$annotation, FUN = length))

environmental$annotation <- as.character(environmental$annotation)
environmental$count <- as.numeric(ave(environmental$annotation, environmental$annotation, FUN = length))

human <- human[order(-human$count),]
cattle <- cattle[order(-cattle$count),]
environmental <- environmental[order(-environmental$count),]

human <- human %>%
  distinct(annotation, .keep_all = TRUE)
cattle <- cattle %>%
  distinct(annotation, .keep_all = TRUE)
environmental <- environmental %>%
  distinct(annotation, .keep_all = TRUE)

human <- human %>% rename(Human = count)
cattle <- cattle %>% rename(Cattle = count)
environmental <- environmental %>% rename(Environmental = count)

tidy_counts <- merge(human, cattle, by = "annotation")
tidy_counts_all <- merge(tidy_counts, environmental, by = "annotation")
tidy_counts_all <- tidy_counts_all[-c(2,3,4,5,7,8,9,10,12,13,14,15)]
tidy_counts_all[is.na(tidy_counts_all)] <- 0

write.csv(tidy_counts_all, file = "~/Documents/Cerro Host Adaptation/HDC_counts_drop0.csv")
  