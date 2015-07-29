#This script creates a data frame that includes expression and total intron counts of a particular gene. 
#'sumcall' will be used to measure gene expression. see 'sumcall' script (found in this package);'sumcall' yields 'df_gene', which contains the 500 summed gene expression values. 


doc <- read.table("numbers_of_introns.tsv", header=TRUE) #'numbers_of_introns.tsv' contains file names in the format 'junctions.ERP001942_ERS185251_ERX162774_ERR188116-1-1.bed'. For Leek Lab purposes, path = '/home/other/nkarbhar/sratissue/numbers_of_introns.tsv'.

counts <-read.table("counts.tsv",sep="\t",header=TRUE, stringsAsFactors=FALSE) #'counts' contains the number of reads mapping to each chromosome from each of 500 bigWig files. 

######################## load gene expression data frame ################################
load("df_gene.Rda") #this is a data frame containing expression of query gene. See script for "sumcall", as this script reports expression as a summed value across all 500 files. 


############ create data frame with total intron counts and summed gene expression ######## 
temp <- " "
namesvec <- vector()
files <- scan("sra_samples.txt", what="", sep="\n")  #this gives a vector of the 500 bigWig file names. 

for (i in 1: length(files)){  #ideally, 'doc' and 'files' will always be the same length, if updated. 
  
  temp <- strsplit(as.character(doc[i, 1]),"junctions.|.bed")[[1]][2] #1st column of 'doc' contains file names. split this to obtain run accession values.
  namesvec[i] <- temp
  
}

doc$file <- namesvec
df_introns_ex <- merge(doc, df_gene, by = 'file') #since 'doc' contains total intron counts, and 'df_gene' contains expression, 'df_introns_ex' now contains all desired values. 






