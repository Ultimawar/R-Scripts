########################
#      Keshav Dial     #
#    June 10th, 2016   #
# BHK Lab @ PMGenomics #
########################

# Remove all existing objects from the workspace
rm(list=ls(all=TRUE))

# Define Library of functions
source(file.path("kdial_library.R"))

########################

# Dependencies for scripts
library(Biobase)
library(GEOquery)
library(gdata)
library(affy)
library(affyPLM)

# Creation of log file and matrix
if (!file.exists("kdial_log.txt")){
	steps <- c("kdial_normalisation", "kdial_temporal")
	progress.log <- cbind(steps, rep("...", length(steps)))
	# Adds labels to the matrix. The first are for the rows, the second list is for the columns
	dimnames(progress.log) <- list(paste("step", 1:length(steps), sep="."), c("script","progress"))
	updateLog("kdial_log.txt")
}else{
	progress.log <-read.table(file=file.path("kdial_log.txt"), sep="\t", header=TRUE, stringsAsFactor=FALSE)
}

##################################
# Download the raw microarray data, perform customised normalisation 

message("\n---------------------------------------\n| Normalisation of Breast Cancer Data |\n---------------------------------------\n")
if (progress.log["step.1","progress"] !="done"){
	progress.log["step.1","progress"] <- "in progress"
	updateLog("kdial_log.txt")
	source("kdial_normalisation.R")
	progress.log["step.1","progress"] <- "done"
	updateLog("kdial_log.txt")
}else{
	message("\t-> DONE")
}

##################################
# Perform Time Analysis on the Normalised Data

message("\n---------------------------------------\n| Time Analysis of Breast Cancer Data |\n---------------------------------------\n")
if (progress.log["step.2","progress"] !="done"){
	progress.log["step.2","progress"] <- "in progress"
	updateLog("kdial_log.txt")
	source("kdial_temporal.R")
	progress.log["step.2","progress"] <- "done"
	updateLog("kdial_log.txt")
}else{
	message("\t-> DONE")
}
