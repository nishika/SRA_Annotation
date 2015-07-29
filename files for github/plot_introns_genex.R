#This script can be used to plot 'total mapped reads' by summed expression of a particular gene. 
#'sumcall' will be used to measure gene expression. see 'sumcall' script (found in this package);'sumcall' yields 'df_gene', which contains the 500 summed gene expression values. 
#'total mapped reads' is used as a rough estimation of amount of splicing; this is a rough quantification of intronic counts for query gene.

counts <-read.table("counts.tsv",sep="\t",header=TRUE, stringsAsFactors=FALSE) #'counts' contains the number of reads mapping to each chromosome from each of 500 bigWig files. 


####create data frame with total mapped reads and summed gene expression #########

totmapreads <- merge(counts, df_gene, by = 'file')  


##### to get only the first element from total mapped reads column in 'totmapreads' #############

totmap <- vector()
temp_totmap <- " "
for (i in 1: 500){
  
  
  temp_totmap <- strsplit(as.character(totmapreads[i, 29]),",")[[1]][1] #column 29 in 'totmappedreads' contains 2 values for total mapped reads for each of the 500 bigWigs; the 1st value is the value of interest.  
  totmap[i] <- temp_totmap
  
}

#### plot total mapped reads against gene expression #######
totmapvec <- as.numeric(totmap)
genexp <- totmapreads$gene_name  #'gene_name' will be the name of the summed expression column in the df_gene data frame. 
plot(totmapvec, genexp, xlab = 'Total Mapped Reads', ylab = 'Sum of Gene Reads')

########## to create a plot of summed gene expression sorted by total mapped reads#################
sorted <- totmapreads[order(totmapreads$total.mapped.reads), ] 
x <- vector()

for (i in 1: 500){
  
  vec_totmap <- strsplit(as.character(sorted[i, 30]),",")[[1]][1]  #column 30 contains the total mapped reads. 
  x[i] <- vec_totmap
  
}

plot(x, sorted, xlab = 'Total Mapped Reads', ylab = 'Sum of Gene Reads')