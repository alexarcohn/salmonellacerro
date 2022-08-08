# ST367_clademembership_piecharts.R
# Alexa R. Cohn
# Feb. 18, 2022

cladeA_sums <- data.frame(
  group = c("Cattle", "Human", "Environmental/Food"),
  value = c(51, 0, 6),
  percent = c(89.5, 0, 10.5)
)

library(ggplot2)
cladeA_bp <- ggplot(cladeA_sums, aes(x="", y=value, fill=group))+
  geom_bar(width=1, stat="identity")
cladeA_bp
cladeA_pie <- cladeA_bp + 
  coord_polar("y", start=0) +
  theme_minimal() +
  theme(
    axis.title.x = element_blank(),
    axis.title.y = element_blank(),
    panel.border = element_blank(),
    panel.grid=element_blank(),
    axis.ticks = element_blank(),
    plot.title=element_text(size=14, face="bold")) +
  ggtitle("Clade A Isolation Sources")
cladeA_pie

cladeB_sums <- data.frame(
  group = c("Cattle", "Human", "Environmental/Food"),
  value = c(17, 4, 19)
)

cladeB_bp <- ggplot(cladeB_sums, aes(x="", y=value, fill=group))+
  geom_bar(width=1, stat="identity")
cladeB_bp
cladeB_pie <- cladeB_bp +
  coord_polar("y", start=0) +
  ggtitle("Clade B SNP Cluster Membership")+
  theme_minimal() +
  theme(
    axis.title.x = element_blank(),
    axis.title.y = element_blank(),
    panel.border = element_blank(),
    panel.grid=element_blank(),
    axis.ticks = element_blank(),
    plot.title=element_text(size=14, face="bold")
  )
cladeB_pie
