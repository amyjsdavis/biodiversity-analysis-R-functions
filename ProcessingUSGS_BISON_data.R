#######January 4, 2017
#####Author: Amy J.S. Davis
##this script extracts the variables I want from USGS BISON data and writes them to a csv file. Unfortunately, the attribute columns vary with BISON data. So, if a column name on the list below is not avaiable, 
it will still be added to the csv file but with value "Missing". Keeping the attributes consistent and in the same order will greatly facilitate joining multiple csv files into one file.

## list of attributes to keep from bison

basisOfRecord
ITISscientificName
decimalLongitude
year
pointPath
decimalLatitude
occurrenceID
recordedBy
eventDate
ownerInstitutionCollectionCode
provider
stateProvince
scientificName
centroid

## some files may be missing the following attributes:
recordedBy, centroid (however the pointPath attribute will say if point is a centroid)


###Read in each .csv file downloaded from bison

##first set working directory. this is extremely important. For example:
setwd("D:\\Data\\Bison_Indiv_Species")

temp <- list.files(pattern="*.csv")## this will list all the files in your working directory



extractBisonData<-function(x){
	bisonfile<-read.csv(x,head=TRUE)
	newdfnames<-c("ITISscientificName","basisOfRecord","year","pointPath","recordedBy","ownerInstitutionCollectionCode","provider","stateProvince","occurrenceID","eventDate","decimalLongitude","decimalLatitude","scientificName","centroid")
	newdf<-bisonfile[,intersect(names(bisonfile),newdfnames)]
	addnames<-setdiff(newdfnames,names(bisonfile))
	newdf1<-as.data.frame(newdf)
	if (length(setdiff(newdfnames,names(bisonfile))> 0)){newdf1[,addnames]<-"MISSING" }
	newdf2<-newdf1[,order(names(newdf1))]
	var1<-toString(levels(newdf2$ITISscientificName))
	write.csv(newdf2,paste(var1,"1.csv", sep=""),row.names=FALSE)
}



##now use species list in "temp"(168 species) and use lapply
procBison<-lapply(temp,extractBisonData) ## this returned 168 species.


##Now check the data to make all the headers are in the same order
#first change working directory to wear the processed files are stored

setwd("D:\\Data\\Bison_Indiv_Species\\procBison")

procFileList<-list.files(pattern="*.csv")
	batchnames<-function(x){
 	y<-read.csv(x,header=TRUE)
 	names(y)
 }

 checknames<-lapply(procFileList,batchnames)

## open this file to check name consistency

write.csv(checknames,"checknames.csv",row.names=FALSE)

##paste rows as transposed columns in excel, if everything looks good then remove checknames files from wd and run the following command in your command window
copy *.csv combined.csv

## but first you need to set your directory
D:\Data\Bison_Indiv_Species\procBison>

##remove duplicate header rows in excel