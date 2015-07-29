#this script gives 'sumcall', a vector of the expression of a particular gene, summed across all genomic positions of a particular big wigs. The vector is 500 values long, containing one summed value for each bigWig file.  
#'sumcall' can be used to holistically measure gene expression. 

library(rtracklayer)
library(magrittr)
library(stringr)

metadata <- load('/home/other/nkarbhar/sratissue/meta.Rda')   #this contains the annotated metadata for the 500 big wig files. 
extract.block <- function(files, chr, start, end, verbose = FALSE){  #extract.block function was provided by Jean-Phillipe Fortin. Thank you Jean-Philippe Fortin!
  rl <- IRanges::RangesList(IRanges::IRanges(start=start, end=end))
  names(rl) <- chr
  
  rles <- lapply(files, function(xx) {
    
    import(xx, as = "Rle", format = "bw", selection = BigWigSelection(rl))
  })
  
  megaMatrix <- do.call(cbind, lapply(rles, function(xx) as.numeric(xx[[chr]][start:end])))
  megaMatrix
}


v1 <- as.vector(update_metadata$run_accession) #update_metadata is the data frame name of 'meta.Rda'
filenames <- scan("sra_samples.txt", what="", sep="\n")

path <- '/dcl01/leek/data/sraonrail/sra_batch_0_sample_size_500_align/coverage_bigwigs/'

sumcall <- numeric(0)

for (i in 1:length(filenames)){
  
  call <- extract.block(paste0(path, filenames[i]),'chr20', 61867235, 61871859)  #input chromosome, start position, and end position.  
  sumcall <- c(sumcall, sum(call))  #make vector of summed gene expression for the 500 bigWigs. 
}

