library(MSnbase)
library(mzID)
library(stringr)

setwd("/root/data")
setwd("~/Documents/GITHUB/msgf/data/biodiversity/")
####################################### READ FILE ###################################################

mzid.files        <- list.files(path = ".", pattern ="mzid", all.files = F, 
                                full.names = F, recursive = F, ignore.case = T, include.dirs = F)
mzml.files        <- list.files(path = ".", pattern ="mzML$|MzXML", all.files = F, 
                                full.names = F, recursive = F, ignore.case = T, include.dirs = F)

mzids.raw         <- mzID(mzid.files)
msexp.raw         <- readMSData(mzml.files)

####################################### IDENTIFICATION ###################################################
print("Identifiying...")
msexp             <- addIdentificationData(msexp.raw, id = mzids.raw)
msexp             <- removeNoId(msexp)
msexp             <- removeMultipleAssignment(msexp)
idSummary(msexp)


####################################### CLEAN UP ###################################################
rm(mzid.files)
rm(mzml.files)
rm(msexp.raw)
rm(mzids.raw)

####################################### QUANTIFICATION ###################################################
print("Quantifying...")
qnt               <- quantify(msexp, method="count", verbose=T)
qnt               <- filterNA(qnt, pNA = 0)
agg               <- combineFeatures(qnt, groupBy = fData(qnt)$accession, fun="mean")
head(exprs(agg))