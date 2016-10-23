#############################################################################
############||||||||-----~~~~~~~. PROJECT_1 .~~~~~~~-----||||||||############
#############################################################################

#Project_1 Statistical Learning (clustering) teaching D.Karlis.
#Athens University of Economics and Business
#by George Kyziridis 

#######SUMMARY#########
#This is a clustering project in Statistical Learning course. 
#The purpose of this project is to make clusters of olive_oils by their chemical variables that they have to do with the acidity of the oil.
#Moreover the acidity have to do with the quality of oil.
#########################################################

#####DATA#########
# We use the oliveoils data_set which contain 10 variables which two of them are categorical variables and the other eight are quantitative.


#First we need to install some packages
packs<-c("corrgram","HDclassif","cluster","mclust","FactMixtAnalysis",
         "nnet","class","tree","ellipse")
install.packages(packs)

library(ellipse)
library(corrgram)
library(HDclassif)
library(cluster)
library(mclust)
library(FactMixtAnalysis)
library(nnet)
library(class)
library(tree)
library(ggplot2)
 

#################################

plot(data , col=data[,1] , main="matrix_scatterplot coloured by Area") #by Area variable
plot(data , col = data[ , 2], main="matrix_scatterplot coloured by Region")  #by Region variable

summary(data)
var(data[,c(-1,-2)])

table(data[,1]) #frequencies for Area
table(data[,2]) #frequencies for Region

############################################################################
#############//////////~~~VARIABLE SELECTION~~~///////////##################
############################################################################

#~ Clustering with all the variables~#
######################################

hc0<-hclust(dist(data[,3:10]) , method="ward.D")
plot(hc0 , main="Dendrogram_Ward's linkage" , xlab = "all quantitative variables")
rect.hclust(hc0 , 2, border = 3)
clas0<-cutree(hc0 , 2)
sil0<-silhouette(clas0 , dist(data[,3:10]))

pdf('My_silhouette_plot')
plot(sil0,main="Silhouette plot for all quantitative variables " , col=1:2)
dev.off()

#maiking object oil with a new colum name cluster....
oil<-data
oil$cl<-clas0
View(oil)
oil$cl<-factor(oil$cl)

#boxplot for all the variables by_cluster
pdf('My_boxplots.pdf')
par(mfrow=c(2,4))
for (i in 3:10) {
  boxplot(oil[,i]~oil$cl , main=paste("for variable :" , i))
}
title("Boxplots for all quantitative variables" , line = -25 , outer=T)
dev.off()

par(mfrow=c(1,1))
oil1<-oil[,c(-5,-8)] #try to get rid of two variables (5 and 8)
hc01<-hclust(dist(oil1[,c(-1,-2)]) , method="ward.D")
plot(hc01 , main="Dendrogram without variables 5 & 8" , xlab="variables : 3,4,6,7,9,10" )
rect.hclust(hc01 , 2 , border = 4)
clas01<-cutree(hc01 , 2)
sil01<-silhouette(clas01 , dist(oil[,c(-1,-2)]))

pdf('My_silhouette 2')
plot(sil01 , col=c(1,2) , main="Silhouette plot without variable 5 & 8")
dev.off()


####################
##~~~Mahalanobis~~##
####################
allcomb<- t(combn(3:10 , 2))
allcomb
res<-NULL
for (i in 1:dim(allcomb)[1]){ 
  print(i)
  x0<-data[,allcomb[i,]]
  mydist<-as.dist(apply(x0,1, function(i) mahalanobis(x0, i , cov=cov(x0))))
  hcm<-hclust(mydist, method="ward.D")
  clasm<-cutree(hcm,2)
  silm<-silhouette(clasm, mydist)
  res<-c(res,mean(silm[,3]))
}

plot(res, main="Scatter_plot silhouette average for all combs" , ylab="average")
best<-allcomb[which.max(res),]
x0<-data[,best] #stearic arachidic are the best we will keep them in the analysis


################################################
#~~Variable_selection_proccess_by_correlation~~#
################################################
r<-cor(data[3:10])
r
corrgram(r, order = F, lower.panel = panel.shade, upper.panel = panel.pie, 
         text.panel = panel.txt, main = "Correlogram__Oliveoil_Data")
plotcorr(r,main="Oliveoil_Data", col = colorRampPalette(c("firebrick3", "white", "navy"))(10))


data1<-data[,c(-3,-4)] #throw out the correlated variables
r1<-cor(data1[,c(-1,-2)])
r1
corrgram(r1 , main="Correlogram data1" , order=F , lower.panel = panel.shade ,
         upper.panel = panel.pie, text.panel = panel.txt )



data2<-data1[,c(-4,-6)]     #without "linolenic" & "oleic"  because correlation..
r2<-cor(data2[,c(-1,-2)])
r2
corrgram(r2 , main="Correlogram data2" , order=F, upper.panel = panel.pie ,
         lower.panel = panel.shade , text.panel = panel.txt)

#These are the variables we will keep in the anaysis
View(data2)


###############################################
#~~~____-Culculation Silhouette values-____~~~#
###############################################

#Dummy_run for 2:9 clusters
hc4<-hclust(dist(data2[,c(-1,-2)]) , method="ward.D")
clas4<-cutree(hc4 , 2:9)

res<-NULL
for (i in 1:8) {
  a<-silhouette(clas4[,i] , dist(data2[, c(-1,-2)]))
  res<-c(res , mean(a[,3]))
}

plot(2:9 , res , type="b" , main="Average Silhouette" , ylim=c(0.0 , 0.8), xlab = "clusters" , 
     ylab = "silhouette average")

###########################
##~~Linkage methods try~~##
###########################

hc1<- hclust(dist(data2[ , c(-1,-2)]) , method="single")
plot(hc1 , main="Dendrogram sinlge_linkage") #chain eefect.... it's usual when we use the single linkage...
clas1<-cutree(hc1 , 2)
s1<-silhouette(clas1 , dist(data2[,c(-1,-2)]))


hc2<- hclust(dist(data2[ , c(-1,-2)]) , method="complete")
plot(hc2 , main="Dendrogram complete_linkage")
rect.hclust(hc2 , 2 ,border = 4)
clas2<-cutree(hc2 , 2)
s2<-silhouette(clas2 , dist(data2[ , c(-1,-2)]))


hc3<-hclust(dist(data2[ , c(-1,-2)]),method="ward.D")
plot(hc3 , main="Dendrogram ward's_linkage")
rect.hclust(hc3 , 2 ,border = 2)  #place a rectiangular around the groups
clas3<-cutree(hc3, k=2)
s3<-silhouette(clas3 , dist(data2[ , c(-1,-2)]))


hca<-hclust(dist(data2[,c(-1,-2)]) , method="average")
plot(hca , main="Dendrogram average_linkage")
clasa<-cutree(hca , 2)
sa<-silhouette(clasa , dist(data2[,c(-1,-2)]))

##############################################
########////~~~~Silhouette~~~~////############
##############################################

pdf('ALL_my_silhouette_plots.pdf')
par(mfrow=c(2,2))
plot(s3 , col = c(1,2) , main="ward linkage")
plot(s1 , col = c(1,2), main="single linkage")
plot(s2 , col=c(1,2) , main="complete linkage")
plot(sa , col=c(1,2) , main="average linkage")
dev.off()


#########################################
###########~~~~Plots_height~~~~##########
#########################################

par(mfrow=c(2,2))
plot(hc1$height , main="Single_linkage" , ylab="Height") # single_linkage
plot(hc2$height , main="Complete_linkage", ylab="Height") # complete_linkage
plot(hc3$height , main="Ward's_linkage", ylab="Height") # Ward's_linkage
plot(hca$height , main="Average_linkage", ylab="Height")
mtext("Height_Plots", outer=T ,line = -2 , side=3 , cex=2 , font=4, col=2)


##################################################
########~~~~--_--~ Wilks Λ_ambda ~--_--~~~~#######
##################################################

olive<-as.matrix(data2[ , c(-1,-2)])
m1 <- manova(olive~clas1) #m1 : manova table according to classification with single linkage
m2<-manova(olive~clas2)
m3<-manova(olive~clas3)
m4<-manova(olive~clasa)
summary(m1, test="Wilks")
summary(m2, test="Wilks")
summary(m3, test="Wilks")
summary(m4, test="Wilks")

mywilks<- summary(m3,test="Wilks")$stats[1,2]

##~~ARI~~##
#clas1:signle linkage with 2 clusters
#clas2:complete linkage with2 clusters
#clas3:Ward linkage with 2 clusters
#clasa:Average linkage with 2 clusters
adjustedRandIndex(clas1,clas3) 
adjustedRandIndex(clas2,clas3)
adjustedRandIndex(clasa,clas3)
adjustedRandIndex(clas2,clasa)
adjustedRandIndex(clas1,clasa)


###########################
## make a new column with the cluster_name
cluster<-clas3
newdata<-data2
newdata$cluster<-factor(cluster)
attach(newdata)
View(newdata)

#################################
##exporting data
write.csv(newdata , "olive_cluster.csv" , row.names=F) #exporting my data clusters


#######################################################
###_/\_-~~~Data_Analysis_whithin_clustering~~~-_/\_###
#######################################################

#####//-Freq ~ Area & Region-//######
plot(newdata , col=newdata$cluster , main="Scatter_plot coloured by cluster")

mytabr<-table(Region,cluster)
mytaba<-table(Area , cluster)
mytabr
mytaba

prop.table(mytabr,1)   #frequency table with percent
prop.table(mytaba ,1)

summary(newdata[which(cluster==1) , ])
summary(newdata[which(cluster==2) , ])

##standardise means for the 2 clusters##
sm1<-NULL
for (i in 3:6) {
  sm1<-c(sm1 , mean(newdata[which(cluster==1) , i]) /(2*sqrt(var(newdata[which(cluster==1) , i]))))
}
sm1 ## means for variables in cluster 1


sm2<-NULL
for (i in 3:6) {
  sm2<-c (sm2 , mean(newdata[which(cluster==2) , i]) / (2*sqrt(var(newdata[which(cluster==2) , i]))))
}
sm2  ## means for variables in cluster 2


##modata : stand.mean for variables for clusters
modata<-rbind(sm1,sm2)
colnames(modata)<-c("stearic","linoleic","arachidic","eicosenoic")
modata

par(mfrow=c(1,2))
barplot(modata[1,] , xlim = c(0,4.5) , ylim = c(0,6), main="cluster_1" , col=1)
barplot(modata[2,] , xlim = c(0,4.5) , ylim = c(0,6), main="cluster_2", col=2)
mtext("Barplots Variables by clusters" , outer=T , cex=1.8 
      , font = 4 , line=-2)


####Histograms for specific variables#####
################################
par(mfrow=c(2,2))
v<-factor(3:6)
levels(v)<-c("stearic","linoleic","arachidic","eicosenoic")
for (i in 3:6) {
  hist(newdata[which(cluster==1),i] ,xlab = v[i-2], main=paste("Histogram",v[i-2]), col="tomato1")
}
mtext("Histograms_Cluster1",  line = -2, outer = TRUE , cex=1.5 , font=2)



par(mfrow=c(2,2))
v<-factor(3:6)
levels(v)<-c("stearic","linoleic","arachidic","eicosenoic")
for (i in 3:6) {
  hist(newdata[which(cluster==2),i] ,xlab=v[i-2], main=paste("Histogram",v[i-2]) , col="tomato4")
}
mtext("Histograms_Cluster2" , outer=T , line=-2 , cex=1.5 , font=4)


##Pie_charts##
##############
pa1<-table(newdata[which(cluster==1),1])
pa2<-table(newdata[which(cluster==2),1])
pr1<-table(newdata[which(cluster==1),2])
pr2<-table(newdata[which(cluster==2),2])

par(mfrow=c(2,2))
pie(pa1 , main="Area cluster1")
pie(pr1, main="Region cluster1")
pie(pa2, main="Area cluster2")
pie(pr2 , main= "Region cluster2")
mtext("PieCharts" , outer=T , line=-3 , cex=2, font = 4)

##BoxPlots##
############

par(mfrow=c(2,2))
v<-factor(3:6)
levels(v)<-c("stearic","linoleic","arachidic","eicosenoic")
for (i in 3:6) {
  boxplot(newdata[,i]~cluster , main=paste("for the variable :" , v[i-2]) )
}
mtext("Boxplots for variables in clusters" , line = -2 , outer=T , cex=1.5 , font = 2)


