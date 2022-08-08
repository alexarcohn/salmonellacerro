### chi square tests for association of PMSC in genes
### Alexa Cohn
### 11 Mar 2021


library(ggplot2)

#speC
spec <- read.csv("~/Documents/Cerro Host Adaptation/speC.csv", header = TRUE)
spec_table <- matrix(c(24, 2, 15, 192, 26, 52), nrow = 2, ncol = 3)
inverse_spec <- matrix(c(24, 15, 26, 2, 192, 52), nrow = 3, ncol = 2)
chisq.test(spec_table, correct=FALSE)
chisq.test(inverse_spec)

human_cattle <- matrix(c(24, 15, 2, 192), nrow = 2, ncol = 2)
fisher.test(human_cattle)
human_environment <- matrix(c(24, 26, 2, 52), nrow = 2, ncol = 2)
fisher.test(human_environment)
cattle_environment <- matrix(c(15, 26, 192, 52), nrow = 2, ncol = 2)
fisher.test(cattle_environment)

#sopA
sopa_human_cattle <- matrix(c(15, 0, 11, 207), nrow = 2, ncol = 2)
fisher.test(sopa_human_cattle)
sopa_human_environment <- matrix(c(15, 7, 11, 71), nrow = 2, ncol = 2)
fisher.test(sopa_human_environment)
sopa_cattle_environment <- matrix(c(0, 7, 207, 71), nrow = 2, ncol = 2)
fisher.test(sopa_cattle_environment)

# clades
clades <- matrix (c(15, 8, 11, 277), nrow = 2, ncol = 2)
fisher.test(clades)
