#Amy Davis

#Script to calculate the last 10 percent of specaccum curve(method="exact") in vegan package. "x" is the object obtained using the #specaccum function in the vegan package. Used exact method as per Yang et al. 2013. Following this paper and others, a rule of thumb is #slopes that are <= to 0.05 are well sampled and >0.05 are under-sampled.

library(vegan)



slope10<-function(x){
maxs<-max(x$sites)
b<-round(maxs-(.10*maxs))
maxr<-x$richness[[maxs]]
minr<-x$richness[[b]]
slope<-(maxr-minr)/(maxs-b)
return(slope)
}

