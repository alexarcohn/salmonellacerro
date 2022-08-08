# date-randomization.R
# Alexa R. Cohn
# Feb. 21, 2022

# install.packages("TipDatingBeast")
library(TipDatingBeast)

setwd("~/Documents/Cerro Host Adaptation/BEAST/")
RandomDates("model23_ST367", reps = 10, writeTrees = T)

PlotDRT("clean", reps = 10, burnin = 0.1)
