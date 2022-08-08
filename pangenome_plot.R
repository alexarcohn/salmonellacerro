library(ggplot2)
conserved = colMeans(read.table("~/Documents/Cerro Host Adaptation/number_of_conserved_genes.Rtab"))
total = colMeans(read.table("~/Documents/Cerro Host Adaptation/number_of_genes_in_pan_genome.Rtab"))
conserved = sort(conserved, decreasing = TRUE)

genes = data.frame(genes_to_genomes = c(conserved,total),
                    genomes = c(c(1:length(conserved)),c(1:length(conserved))),
                    Key = c(rep("Conserved genes",length(conserved)), rep("Total genes",length(total))))

ggplot(data = genes, aes(x = genomes, y = genes_to_genomes, group = Key, linetype=Key))+
  geom_line()+
  theme_classic()+
  ylim(c(3000,max(total)))+
  xlim(c(1,length(total)))+
  xlab("No. of genomes")+
  ylab("No. of genes")
