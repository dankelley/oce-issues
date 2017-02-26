rm(list=ls())
library(oce)
library(ncdf4)

d <- read.oce('6900835_prof.nc')
nc <- nc_open('6900835_prof.nc')

## read fields
pressure <- ncvar_get(nc, 'PRES')
salinity <- ncvar_get(nc, 'PSAL')
temperature <- ncvar_get(nc, 'TEMP')

## read QC related fields
positionQC <- ncvar_get(nc, 'POSITION_QC')
dataMode <- ncvar_get(nc, 'DATA_MODE')
profilePressureQC <- ncvar_get(nc, 'PROFILE_PRES_QC')
profileSalinityQC <- ncvar_get(nc, 'PROFILE_PSAL_QC')
profileTemperatureQC <- ncvar_get(nc, 'PROFILE_TEMP_QC')
pressureQC <- ncvar_get(nc, 'PRES_QC')
pressureAdjusted <- ncvar_get(nc, 'PRES_ADJUSTED')
pressureAdjustedQC <- ncvar_get(nc, 'PRES_ADJUSTED_QC')
pressureAdjustedError <- ncvar_get(nc, 'PRES_ADJUSTED_ERROR')
salinityQC <- ncvar_get(nc, 'PSAL_QC')
salinityAdjusted <- ncvar_get(nc, 'PSAL_ADJUSTED')
salinityAdjustedQC <- ncvar_get(nc, 'PSAL_ADJUSTED_QC')
salinityAdjustedError <- ncvar_get(nc, 'PSAL_ADJUSTED_ERROR')
temperatureQC <- ncvar_get(nc, 'TEMP_QC')
temperatureAdjusted <- ncvar_get(nc, 'TEMP_ADJUSTED')
temperatureAdjustedQC <- ncvar_get(nc, 'TEMP_ADJUSTED_QC')
temperatureAdjustedError <- ncvar_get(nc, 'TEMP_ADJUSTED_ERROR')

## decode the weird QC vectors into matrices
dim <- dim(temperature)
temperatureQ <- array(as.numeric(unlist(strsplit(temperatureQC, ''))), dim=dim)
salinityQ <- array(as.numeric(unlist(strsplit(salinityQC, ''))), dim=dim)
pressureQ <- array(as.numeric(unlist(strsplit(pressureQC, ''))), dim=dim)
temperatureAdjustedQ <- array(as.numeric(unlist(strsplit(temperatureAdjustedQC, ''))), dim=dim)
salinityAdjustedQ <- array(as.numeric(unlist(strsplit(salinityAdjustedQC, ''))), dim=dim)
pressureAdjustedQ <- array(as.numeric(unlist(strsplit(pressureAdjustedQC, ''))), dim=dim)

if (!interactive()) png('759a-%03d.png')
par(mfrow=c(2, 1))

imagep(temperature)
title('temperature')
imagep(temperatureQ, breaks=0:4)
title('temperature QC flags')

imagep(temperatureAdjusted)
title('temperature adjusted')
imagep(temperatureAdjusted - temperature)
title('temperatureAdjusted - temperature')

imagep(salinity)
title('salinity')
imagep(salinityQ, breaks=0:4)
title('salinity QC flags')

imagep(salinityAdjusted)
title('salinity adjusted')
imagep(salinityAdjusted - salinity)
title('salinityAdjusted - salinity')

imagep(pressure)
title('pressure')
imagep(pressureQ, breaks=0:4)
title('pressure QC flags')

imagep(pressureAdjusted)
title('pressure adjusted')
imagep(pressureAdjusted - pressure)
title('pressureAdjusted - pressure')
      
if (!interactive()) dev.off()
