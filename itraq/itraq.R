library(MSnbase)
library(mzID)
library(stringr)

setwd("/root/data")

####################################### READ FILE ###################################################

mzid.files        <- list.files(path = ".", pattern ="mzid", all.files = F, 
                       full.names = F, recursive = F, ignore.case = T, include.dirs = F)
mzml.files        <- list.files(path = ".", pattern ="mzML$", all.files = F, 
                       full.names = F, recursive = F, ignore.case = T, include.dirs = F)

mzids.raw         <- mzID(mzid.files)
msexp.raw         <- readMSData(mzml.files)

####################################### IDENTIFICATION ###################################################
print("Identifiying...")
msexp             <- addIdentificationData(msexp.raw, id = mzids.raw)
msexp             <- removeNoId(msexp)
msexp             <- removeMultipleAssignment(msexp)
idSummary(msexp)

####################################### QUANTIFICATION ###################################################
print("Quantifying...")
qnt               <- quantify(msexp, method="max", reporters=iTRAQ4, strict=F, verbose=F)
qnt               <- filterNA(qnt, pNA = 0)
agg               <- combineFeatures(qnt, groupBy = fData(qnt)$accession, fun="mean")

####################################### CLEAN UP ###################################################
rm(mzid.files)
rm(mzml.files)
head(exprs(agg))
####################################### OUTPUT ###################################################
print("Writing the output...")
write.csv(as.data.frame(cbind(Accession_ID=str_replace(row.names(agg),"ref\\|",""),exprs(agg))), row.names = F, file="LabelledQuant.csv")
save.image(file="LabelledQuant.csv")
