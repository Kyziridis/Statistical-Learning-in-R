# Statistical Learning in R

## Abstract
In this project we are interested in creating clusters of some olive_oil originated from various areas in Italy. These clusters must be made 
according to the acidity, which depends on the quality of the oil.This way we can decide which place in Italy has the best oil.
The data_set we have contains 572 samples of oils, two factorial variables and eight quantitative variables which have to do with the acidity of oils.

### Acidity
Acidity of oliveoils is a significant criterion that defines the quality of the oil. As the acidity is in low levels, as the  quality of the oil will be good.
Typically the oils that have a good taste and smell, have low acidity too. An appropriate percentage would be under 0.8%. 

### Variables
We have two factorial variables and eight quantitative which are presented below. 

+ Region (1=South, 2=Sardinia, 3=North)
+ Area (1=North Apulia, 2=Calabria, 3=South Apulia, 4=Sicily, 5=Inland Sardinia,6=Coastal Sardinia, 7=Umbria, 8=East Liguria, 9=West Liguria
+ palmitic acid (% in sample)
+ palmitoleic acid
+ stearic acid
+ oleic acid
+ linoleic acid
+ linolenic acid
+ arachidic acid
+ eicosenoic acid

> #### This is a frequency table of our data

|North | Sardinia | South |
|-------|----------|------|
|151    |   98     |  323 |

+ So we have a lot of observations from the South , some average observations coming from the North and only a few from Sardinia.

----

### Some basic information about the method we will develope
[Hierarhical Clustering](http://www.saedsayad.com/clustering_hierarchical.htm) is a way to make clusters of observations and it is based on distance methods.
The basic idea in this project is first to examine our data and analyse them in order to see some discriptive statistics such us correlation/variance/mean/kurtosis etc.
Then we have to find wich variables are usefull to our clustering issue.More specifically which are the significant variables that deduce the quality of the oil and help us to classify the data into groups.
After that we have to make some probes of some distance methods between the observations and some linkage methods in spite of making solid clusters.
The purpose is to make compact groups where the observations will be alike into them and differential between them, so in one group we must have a quite same observations with low variance and unsimilar observations between the groups

-----

### Let's have a look on data
Let's see a matrix scatterplot of the dataset, coloured by the Region. This is without some variables in a way to visualize it correctly.

[![matrix.png](https://s12.postimg.org/kaathasz1/matrix.png)](https://postimg.org/image/4othxch0p/)

+ We can se easily see, that the big amount of observations we have, doesn't help us to separate the data into groups. Besides, we can see that a few certain variables seems to be separating observations into groups for example eicosenoic and oleic.
That is our first evidence of what we have to do in the variable selection. 
Remember that the purpose is to classify the data into clusters so we have to find the variables that will help us within this data separation.

----

+ An other thought that will be usefull for our cluster analysis is the data correlation. We must detect the high correlated variables, as they might create some trouble. Consider that we must have strong relations within clusters.
For this reason we set_up the corrgram R.package to visualize the correlation like in the chart below. Note that the red colour it means that we have negative correlation and the blue means positive.

[![corrrrr.png](https://s13.postimg.org/ekd1cgz13/corrrrr.png)](https://postimg.org/image/q9h10fpzn/)

----

Afterwards we can start creating clusters and test whether they are separated properly, or not. 
This procedure can be accomplished in many ways. In this project we specifically visualize the clusters in a Dedrogramm_Plot which helps us to define if the data have been devided in a correctly.
The example below is a typical Dendrogramm with [Ward's linkage method](https://en.wikipedia.org/wiki/Ward%27s_method).
I prefer Ward's linkage because I want to summon strong and massive groups with an elliptic shape.This is the optimum way to accomplish the purpose above.
Nonetheless in the script I have tested all the various ways and methods of clustering.
The dedrogramm below has two green boxes which present us that the data are divided into two clusters. 

[![dendro.png](https://s14.postimg.org/dywr0yk69/dendro.png)](https://postimg.org/image/gg8i8842l/)

----

To go over this procedure above we will examine our clusters with the external use od silhouette method. 
This method is also visual in order to examine furtherly the amount of wich observations fall into each cluster and if they are separated fairly.
The silhouette average which is in the bottom of the plot, definds if the clusters are corrcet with a percentage. If the average value is higher than 0.5% then the clusters are fine.
This is an example of a silhouette plot with two clusters.

[![Screenshot from 2016-10-23 19:04:10.png](https://s18.postimg.org/hf3ioakfd/Screenshot_from_2016_10_23_19_04_10.png)](https://postimg.org/image/p7u6g9qed/)

----

###Conclution
After a number of tries of making clusters we arrived at the conclusion that there is a strong affection in the Area and the acidity of the oil. The data clustered by variables of acidity, so we conduce in two groups with oil. In other words these groups show us that some Italy areas bear better oliveoil than others. For example, cluster analysis defines that the oil of Sardinia has high levels acidity, consequently it is not so qualitative.

> In the project_script.R you will see the whole procedure of making clusters in different ways. Hope to enjoy....





