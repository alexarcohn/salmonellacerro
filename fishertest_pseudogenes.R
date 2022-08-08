# fisher tests for overrepresentation of pseudogenes
# Alexa R Cohn
# 31 March 2021

# load in data
HDC_counts <- read.csv("~/Documents/Cerro Host Adaptation/HDC_counts.csv")

## add in columns for odds ratios and p values
HDC_counts$OR_H_C <- HDC_counts$OR_C_E <- HDC_counts$OR_H_E <-  NA
HDC_counts$p_H_C <- HDC_counts$p_C_E <- HDC_counts$p_H_E <-  NA

## create vectors with number of isolates per category
human_counts <- sum(HDC_counts$Human)
environmental_counts <- sum(HDC_counts$Environmental)
cattle_counts <- sum(HDC_counts$Cattle)

# Loop over all HDCs.
for (i in 1:nrow(HDC_counts)) {
  # For each isolate type, get the counts associated with pseudogene i.
  human_counts_in = HDC_counts$Human[i]
  cattle_counts_in = HDC_counts$Cattle[i]
  environmental_counts_in = HDC_counts$Environmental[i]
  # For each isolate type, get the counts that does not belong to pseudogene i.
  human_counts_out = human_counts - human_counts_in
  cattle_counts_out = cattle_counts - cattle_counts_in
  environmental_counts_out = environmental_counts - environmental_counts_in
  
  # Calculate the odds ratio for
  # the three comparisons.
  or_H_C = (human_counts_in/cattle_counts_in)/(human_counts_out/cattle_counts_out)
  or_C_E = (cattle_counts_in/environmental_counts_in)/(cattle_counts_out/environmental_counts_out)
  or_H_E = (human_counts_in/environmental_counts_in)/(human_counts_out/environmental_counts_out)
  
  # Create 2*2 table of Fisher's test for human vs cattle
  fetb_H_C <- matrix(rep(NA, 4), nrow = 2)
  colnames(fetb_H_C) <- c("Human", "Cattle")
  rownames(fetb_H_C) <- c("HDC", "intact")
  fetb_H_C[1,1] <- human_counts_in
  fetb_H_C[1,2] <- cattle_counts_in
  fetb_H_C[2,1] <- human_counts_out
  fetb_H_C[2,2] <- cattle_counts_out
  
  # Create 2*2 table of Fisher's test for cattle vs environmental
  fetb_C_E <- matrix(rep(NA, 4), nrow = 2)
  colnames(fetb_C_E) <- c("cattle", "environmental")
  rownames(fetb_C_E) <- c("HDCs", "intact")
  fetb_C_E[1,1] <- cattle_counts_in
  fetb_C_E[1,2] <- environmental_counts_in
  fetb_C_E[2,1] <- cattle_counts_out
  fetb_C_E[2,2] <- environmental_counts_out
  
  # Create 2*2 table of Fisher's test for human vs environmental
  fetb_H_E <- matrix(rep(NA, 4), nrow = 2)
  colnames(fetb_H_E) <- c("human", "environmental")
  rownames(fetb_H_E) <- c("HDCs", "intact")
  fetb_H_E[1,1] <- human_counts_in
  fetb_H_E[1,2] <- environmental_counts_in
  fetb_H_E[2,1] <- human_counts_out
  fetb_H_E[2,2] <- environmental_counts_out
  
  # Fisher's test for human vs cattle
  if (is.na(or_H_C)) {
    p_H_C <- 'Both human and cattle have 0 counts'
  } else {
    results <- fisher.test(fetb_H_C, alternative = "less")
    p_H_C <- results$p.value
  }
  
  # Fisher's test for cattle vs environmental
  if (is.na(or_C_E)) {
    p_C_E <- 'Both cattle and environmental have 0 counts'
  }  else {
    results <- fisher.test(fetb_C_E, alternative = "less")
    p_C_E <- results$p.value
  }
  
  # Fisher's test for human vs environmental
  if (is.na(or_H_E)) {
    p_H_E <- 'Both human and environmental have 0 counts'
  }  else {
    results <- fisher.test(fetb_H_E, alternative = "less")
    p_H_E <- results$p.value
  }
  
  # Fill in the odds ratios and unadjusted P-values.
  HDC_counts$OR_H_C[i] <- or_H_C
  HDC_counts$OR_H_E[i] <- or_H_E
  HDC_counts$OR_C_E[i] <- or_C_E
  
  HDC_counts$p_H_C[i] <- p_H_C
  HDC_counts$p_H_E[i] <- p_H_E
  HDC_counts$p_C_E[i] <- p_C_E
  
  
}

write.csv(HDC_counts, "~/Documents/Cerro Host Adaptation/fishertest_pseudogenes.csv")