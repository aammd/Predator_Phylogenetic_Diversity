###################################################################################################
###############This section is for combining chironomid.IDs.csv with insectslong.csv###############
###########################using information from scoped.insects.csv ##############################

################################

##examine the species in each dataset
names(chironomid.ids)
names(insects)

#combine scope identifications with tray identifications
total <- merge(
               x=subset(chironomid.ids,select=-c(Bromeliad..,Leaf..)),  #prevents NAs in this field later.
               y=insects,
               by="leaf.ID",
               all.y=TRUE  #we need all.y because insects is the whole data; chironomid.ids only part
## identify species which are the same
               )

total[is.na(total)] <- 0 #my perfectly reasonable biological reason for replacing NA with 0 is that these are real zeros.

total <- combine.rows("Monopelopia.y","Monopelopia.x","Monopelopia.spp")

total <- combine.rows("Psychodid.little.y","Psychodid.little.x","Psychodid.little")

total <- combine.rows("Tipulid.y","Tipulid.x","Tipulid")

total <- combine.rows("Tanytarsus.y","Tanytarsus.x","Tanytarsus.spp")

total <- combine.rows("Dasyhelea.sp.","aff..Dasyhelea","Dasyhelea.spp")

#Chironomus
total <- combine.rows("Chironomus.aff..detriticula",
                      "Chironomus.dentriticula",
                      "Chironomus.detriticula")
#Culex
total <- combine.rows("Culex.sp.","Culex","Culex.spp")
#polypedilium
total <- combine.rows("Polypedilum.1","Polypedium.species1","Polypedilum.sp1")

total <- combine.rows("Polypedilum.2","Polypedium.species2","Polypedilum.sp2")

## All the identified chironomids subtracted from chironomids sent to scope.
scoped.chiros <- data.frame(leaf.ID=chironomid.ids[,3],  #keeps the labels from chironomid.ids 
                            identified.chiros=-1*rowSums(chironomid.ids[,4:24]*as.numeric(scoped[,4:24]=="chiro"))  #pick up on chironomids that are identified and add them all together. MULTIPLIED by -1 so that I can use combine.rows and be cheap.
                            )

total <- merge(x=total,y=scoped.chiros,by="leaf.ID",all.x=TRUE)
rm(scoped.chiros)

total[is.na(total)] <- 0 #my perfectly reasonable biological reason for replacing NA with 0 is that these are real zeros.

with(total,plot(identified.chiros,x.forscope.chironomid))
abline(0,-1)

#Creates negative numbers?!  of course, but why?  

test<-cbind(total$x.forscope.chironomid,total$identified.chiros)
test <- cbind(test,rowSums(test))  #creates a third column that has the problematic negative numbers.

total[which(test[,3]<0),c("leaf.ID","x.forscope.chironomid","identified.chiros")] #here are the problematic ones

#I think it is OK if we just replace these negative ones with zeros, since we were not too careful about always writing down.  its just important when there IS a difference that we note unidentified ones.

total <- combine.rows("x.forscope.chironomid","identified.chiros","unidentified.chironomids")
total[which(total$unidentified.chironomids<(-10)),]  # a particularly problematic row
total[which(total$unidentified.chironomids<0),"unidentified.chironomids"] <- 0



#########################################

## All the identified chironomids subtracted from chironomids sent to scope.
scoped.psychos <- data.frame(leaf.ID=chironomid.ids[,3],  #keeps the labels from chironomid.ids 
                            identified.psychos=-1*rowSums(chironomid.ids[,4:24]*as.numeric(scoped[,4:24]=="psycho"))  #pick up on chironomids that are identified and add them all together. MULTIPLIED by -1 so that I can use combine.rows and be cheap.
                            )

total <- merge(x=total,y=scoped.psychos,by="leaf.ID",all.x=TRUE)
rm(scoped.psychos)

total[is.na(total)] <- 0 #my perfectly reasonable biological reason for replacing NA with 0 is that these are real zeros.

#Creates negative numbers?!  of course, but why?  

test<-cbind(total$x.forscope.psychodid,total$identified.psychos)
test <- cbind(test,rowSums(test))  #creates a third column that has the problematic negative numbers.

total[which(test[,3]<0),c("leaf.ID","x.forscope.psychodid","identified.psychos")] #here are the problematic ones

#I think it is OK if we just replace these negative ones with zeros, since we were not too careful about always writing down.  its just important when there IS a difference that we note unidentified ones.

total <- combine.rows("x.forscope.psychodid",
                      "identified.psychos",
                      "unidentified.psychodids")

total[which(total$unidentified.psychodids<0),"unidentified.psychodids"] <- 0

#########################################


## All the identified chironomids subtracted from chironomids sent to scope.
scoped.misc <- data.frame(leaf.ID=chironomid.ids[,3],  #keeps the labels from chironomid.ids 
                            identified.misc=-1*rowSums(chironomid.ids[,4:24]*as.numeric(scoped[,4:24]=="misc"))  #pick up on chironomids that are identified and add them all together. MULTIPLIED by -1 so that I can use combine.rows and be cheap.
                            )

total <- merge(x=total,y=scoped.misc,by="leaf.ID",all.x=TRUE)
rm(scoped.misc)

total[is.na(total)] <- 0 #my perfectly reasonable biological reason for replacing NA with 0 is that these are real zeros.

#Creates negative numbers?!  of course, but why?  

test<-cbind(total$x.forscope.misc,total$identified.misc)
test <- cbind(test,rowSums(test))  #creates a third column that has the problematic negative numbers.

total[which(test[,3]<0),c("leaf.ID","x.forscope.misc","identified.misc")] #here are the problematic ones

#I think it is OK if we just replace these negative ones with zeros, since we were not too careful about always writing down.  its just important when there IS a difference that we note unidentified ones.

total <- combine.rows("x.forscope.misc","identified.misc","unidentified")


total[which(total$unidentified<0),"unidentified"] <- 0




##remove columns that Diane wont want.

## all identified chironomids
##

names(total)


####### merge with bromeliad data

insects.brom <- merge(lvs[,c("Bromeliad",'leaf.ID')],total)
head(insects.brom)

bromeliad.species <- aggregate(insects.brom[,-c(1,2)],by=list(brom=insects.brom$Bromeliad),sum)

##############################################################################################################
###############################the following writes the result to shared dropbox data#########################
##############################################################################################################
#write.csv(bromeliad.species,file="~/Dropbox/CommunityAnalysis/Data/Cardoso.leaf.by.leaf.2011/species.by.bromeliads.csv")

###### aggregate (sum) all leaves

brom.vol <- with(lvs,tapply(vol,Bromeliad,sum,na.rm=TRUE))
brom <- merge(brom,data.frame(Bromeliad=names(brom.vol),volume=brom.vol))

## write one dataset that is the Bromeliad data

#write.csv(brom,file="~/Dropbox/CommunityAnalysis/Data/Cardoso.leaf.by.leaf.2011/bromeliad data.csv")

write.csv(insects.brom,file="~/Dropbox/PhD/brazilexperiment/lxl/all.insects.csv")
