rm(list=ls())
library(oce)
library(ncdf4)
## source('~/src/R-richards/oce/R/argo.R')
source('argo.R')

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
salinityQC <- ncvar_get(nc, 'PSAL_QC')
salinityAdjusted <- ncvar_get(nc, 'PSAL_ADJUSTED')
salinityAdjustedQC <- ncvar_get(nc, 'PSAL_ADJUSTED_QC')
temperatureQC <- ncvar_get(nc, 'TEMP_QC')
temperatureAdjusted <- ncvar_get(nc, 'TEMP_ADJUSTED')
temperatureAdjustedQC <- ncvar_get(nc, 'TEMP_ADJUSTED_QC')

## decode the weird QC vectors
dim <- dim(temperature)
TQC <- array(as.numeric(unlist(strsplit(temperatureQC, ''))), dim=dim)
SQC <- array(as.numeric(unlist(strsplit(salinityQC, ''))), dim=dim)
PQC <- array(as.numeric(unlist(strsplit(pressureQC, ''))), dim=dim)
