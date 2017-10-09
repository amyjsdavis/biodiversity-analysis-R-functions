
#####procedure followed for downloading BISON data on Dec 16, 2016.


##load relevant libraries
library(jsonlite)
library(utils)

##import list of species to be downloaded from USGS bison and url encode them. Make sure there are no "non-breaking spaces" (alt 0160) in your excel spread sheet of species names.

specieslist<-read.csv(file="D:\\Aquatic_Rdata\\PlantListDec2_2016_forR.csv", head=TRUE, sep=",")##example data


## here is the script

extractSolr<-function(x) {
y<-lapply(x,reserved=FALSE,URLencode)
link<-c("http://bison.usgs.gov/solr/occurrences/select/?q=ITISscientificName:%22")
link2<-"%22&wt=json&rows=10000" #the number of rows of data to download
link1<-paste(link,y,link2,sep="")
data<-fromJSON(link1)
data2<-as.data.frame(data$response$docs)
data3<-subset(data2,select =-c(TSNs))   ###this TSN attribute ends being a list of lists and is not necessary. When included, you can't write csv file.
name<-paste(data$response$docs$scientificName[[1]],".csv",sep="")
write.csv(data3,name,row.names=FALSE)
}


###to run script over a list of species, and not stop when arriving at a species with  no data to download use lapply and tryCatch
 output<-lapply(specieslist2,function(x) tryCatch(extractSolr(x),error=function(e) NULL))

168 out of 183 species had data on them

