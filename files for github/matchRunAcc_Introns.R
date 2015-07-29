#This script matches run accession indices reported in 'all_sra_introns' with run accession names ###############
#Script written for developers' purposes. 

library(stringr)

file <- 'the file of intron indices'  # for Leek Lab purposes, '/dcl01/leek/data/sraintrons/index_to_SRA_accession.tsv'
datafile <- read.table('insert path here') #datafile will be the file containing all introns. For Leek Lab purposes, '/dcl01/leek/data/sraintrons/all_sra_introns.tsv.gz' 
datafile$runacc <- length(datafile) #make a new column in the file
vec <- vector()
v1 <- vector()
##### fills intron table with a column of the run accessions #######
for(i in 1:nrow(datathing)){  
  
  vec <- datafile[i, 7]  #for each row, make vector containing all mapped run accession indices (comma-separated).
  x <- unlist(lapply(strsplit(gsub('"', '', vec[i]), split = ","), as.numeric)) #split 'vec' by commas, creating a vector 'x' of just run acc index values
  for (i in 1:length(x)){       #however long that vector for the specified row is...
   row <- which(file %in% x[i])  #look for the given index number in 'file', and return the row
    val <- file[row, 5] #5th column contains run accession values. 
    v1 <- c(v1, val) #make vector of all run acc's for each row in datafile. 
    datafile$runacc <- v1  #fill intron file with a column of run acc names. 
  }
}
####### make a new data frame, containing each run acc and all the reads that map to it #####
for (i in 1: nrow (datafile)){
  vec_runacc <- as.numeric(datafile[i, 9]) #column 9 = run accessions
  vec_reads <- as.numeric(datafile [i, 8]) #column 8 = number of reads
  
  df_all <- c(vec_runacc, vec_reads)
}


###### checking the fill column #####

v2 <- c(1, 2, 4, 5)
for (i in 1: nrow(samp)){
  samp[i, 2] <- v2[i] 
}
######take run accessions and get unique values ##########

######  checking the for loop #######



thingy <- vector()

for(i in 1:nrow(samp)){
  
  vec <- samp[i, 4]
  thing <- unlist(lapply(strsplit(gsub('"', '', vec[i]), split = ","), as.numeric))
  thingy <- c(thingy, thing)
}

samp$runacc <- length(samp)

v2 <- c(1, 2, 4, 5)
for (i in 1: nrow(samp)){
  samp[i, 2] <- v2[i] 
}


