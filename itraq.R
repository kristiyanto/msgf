library(MSnbase)
library(MSnID)
library(rpx)
library(mzID)

setwd("C:/Users/kris239/Desktop/itraq")

mzid        <- list.files(path = ".", pattern ="mzid", all.files = F, 
                       full.names = F, recursive = F, ignore.case = T, include.dirs = F)

mzml.files  <- list.files(path = ".", pattern ="mzML$", all.files = F, 
                       full.names = F, recursive = F, ignore.case = T, include.dirs = F)

msexp <- readMSData(mzml.files, verbose = FALSE)
msexp <- addIdentificationData(msexp, id = mzid, verbose = FALSE)
idSummary(msexp)
msexp

mz(msexp)
qnt <- quantify(msexp, method="trap", reporters=iTRAQ4, strict=F)
