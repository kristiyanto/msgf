library(MSnbase)
library(mzID)

setwd("/root/data")

####################################### READ FILE ###################################################

mzid.files        <- list.files(path = ".", pattern ="mzid", all.files = F, 
                       full.names = F, recursive = F, ignore.case = T, include.dirs = F)[2]
mzml.files        <- list.files(path = ".", pattern ="mzML$", all.files = F, 
                       full.names = F, recursive = F, ignore.case = T, include.dirs = F)[2]

mzids.raw         <- mzID(mzid.files)
msexp.raw         <- readMSData(mzml.files)

####################################### IDENTIFICATION ###################################################

msexp             <- addIdentificationData(msexp.raw, id = mzids.raw)
msexp             <- removeNoId(msexp)
msexp             <- removeMultipleAssignment(msexp)
idSummary(msexp)

####################################### QUANTIFICATION ###################################################
qnt               <- quantify(msexp, method="max", reporters=iTRAQ4, strict=F, verbose=F)
qnt               <- filterNA(qnt, pNA = 0)
agg               <- combineFeatures(qnt, groupBy = fData(qnt)$accession, fun="mean")

####################################### CLEAN UP ###################################################
rm(mzid.files)
rm(mzml.files)
head(exprs(agg))
####################################### OUTPUT ###################################################
save.image(file="Labelled-Quant.RData")
write.csv(as.data.frame(cbind(Assccession=row.names(agg),exprs(agg))), row.names = F, file="LabelledQuant.csv")

