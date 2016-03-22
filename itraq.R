library(MSnbase)
library(mzID)

setwd("~/Documents/GITHUB/msgf/data/")

mzid.files        <- list.files(path = ".", pattern ="mzid", all.files = F, 
                       full.names = F, recursive = F, ignore.case = T, include.dirs = F)
mzml.files        <- list.files(path = ".", pattern ="mzML$", all.files = F, 
                       full.names = F, recursive = F, ignore.case = T, include.dirs = F)
mzids.raw         <- mzID(mzid.files)
msexp.raw         <- readMSData(mzml.files, verbose = FALSE)
msexp.id          <- addIdentificationData(object=msexp.raw, id = mzid.files, verbose=T)
idSummary(msexp.id)
msexp.id

head(fData(msexp.id))
qnt <- quantify(msexp.id, method="trap", reporters=iTRAQ4, strict=F)
