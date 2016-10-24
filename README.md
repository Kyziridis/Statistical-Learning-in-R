# Statistical Learning in R

##Abstract
In this project we are concered about making clusters of some olive_oils came from various areas in Italy. These clusters must be made 
according to the acidity, so the quality of the oils. In this way we can decide which place in Italy has the best oil.
The data_set we have contains 572 samples of oils, two categorical variables and eight quantitative variables that they have to do with the acidity of oils.

###Acidity
Acidity of oliveoils is a significant criterion that defines the quality of the oil. As the acidity is in low levels, as the  quality of the oil will be good.
Typically the oils that have a good taste and smell, have low acidity too for example under 0.8%. 

###Variables
We have two categorical and eight quantitative variables which are sown below. 

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

###Some basic things about the method we will develope
[Hierarhical Clustering](http://www.saedsayad.com/clustering_hierarchical.htm) is a way to make clusters of observations and it is based on distance methods.
The basic idea in this project is first to look our data and analyse them in order to see some discriptive statistics such us correlation/variance/mean/kurtosis etc.
Then we have to find wich variables are usefull to our clustering problem.In other words which are the significant variables that deduce the quality of the oils and helps us to clasify the data into groups.
After that we have to make some probes of some distance methods between the observations and some linkage methods in spite of making solid clusters.
The purpose is to make compact groups where the observations will be alike into them and differential between them, so in one group we must have a little bit same observations with low variance and uneven observations between the groups

-----

###Let's have a look on data
Let's see a matrix scatterplot of the dataset, coloured by the Region. This is without some variables in a way to visualize it correctly.

[![matrix.png](https://s12.postimg.org/kaathasz1/matrix.png)](https://postimg.org/image/4othxch0p/)

+ We can se easily see, that the big amount of observations we have, doesn't help us to separate the data into groups. Besides, we can see that a few certain variables seems to be separating observations into groups for example eicosenoic and oleic.
That is our first evidence of what we have to do in the variable selection. 
Remember that the purpose is to classify the data into clusters so we have to find the variables that helps us for data separation.

----

+ An other thing that it will be usefull for our cluster analysis is the data correlation. We must detect the high correlated variables to have in mind that they will make some problems. Think that we must have strong relations within clusters.
For this reason we set_up the corrgram R.package to visualize the correlation like in the chart below. Remember that the red colour it means that we have negative correlation and the blue means positive.

[![corrrrr.png](https://s13.postimg.org/ekd1cgz13/corrrrr.png)](https://postimg.org/image/q9h10fpzn/)

----

Afterwards we can start doing tries of clusters and test if they are separating the data correctly. 
This will be done with many ways, here in this project we visualize the clusters in a Dedrogramm_Plot which helps us to define if the data have been devided in a correct way.
The example below is a typical Dendrogramm with [Ward's linkage method](https://en.wikipedia.org/wiki/Ward%27s_method).
I prefer Ward's linkage because I want to summon strong and massive groups with an elliptic shape and this is suitable linkage for this purpose. 
Nonetheless in the script I have tested all the different ways and methods of clustering.
The dedrogramm below has two green boxes which are shown us that the data splits into two clusters. 

[![dendro.png](https://s14.postimg.org/dywr0yk69/dendro.png)](https://postimg.org/image/gg8i8842l/)

----

We have to test this decision we've made with the silhouette method. 
This is again a visual way to see how many observations get into each cluster and if they are separated fairly.
The silhouette average which is in the bottom of the plot, describes if the clusters are corrcet with a percentage, if the average is bigger than 0.5% then the clusters are ok.
This is an example of a silhouette plot with two clusters.

[![Screenshot from 2016-10-23 19:04:10.png](https://s18.postimg.org/hf3ioakfd/Screenshot_from_2016_10_23_19_04_10.png)](https://postimg.org/image/p7u6g9qed/)

----

###Conclution
In the project_script.R you will see the hole procedure of making clusters in a different ways. 
After a number of tries of making clusters in variaty ways, we arrived at the conclusion that there is a strong affection in the Area and the acidity of the oils. The data are clustered by their variables of acidity, so we conduce to two groups with oils which are containing some hole territories. In other words these groups show us that some Italy areas bear better oliveoil than others. For example the cluster analysis shows that the oil of Sardinia have high levels of acidity so it is not so qualitative.





