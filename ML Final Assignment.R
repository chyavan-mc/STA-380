```{r}
wine = read.csv("C:/Users/Alisha/Desktop/wine.csv")
wine=wine[ , names(wine) != "color"]
wine$new <- c(color)

```

```{r PCA Analysis}
pr.out = prcomp(wine, ncp=5, scale = TRUE)
names(pr.out)
pr.out$center #means of variables
pr.out$scale #standard deviations of variables
pr.out$rotation
dim(pr.out$x)
biplot(pr.out, scale =0)
pr.out$rotation = -pr.out$rotation
pr.out$x = -pr.out$x
biplot(pr.out, scale = 0)
pr.out$sdev
pr.var = pr.out$sdev^2
pr.var
pve = pr.var/sum(pr.var)
pve
#PVE explained by each component
plot(pve, xlab = "Principal Component", ylab = "Proportion of Variance Explained", ylim = c(0,1), type = 'b')
#the cumulative PVE
plot(cumsum(pve), xlab = "Principal Component", ylab = "Cumulative Proportion of Variance Explained", ylim = c(0,1), type = 'b')
```

```{r}
#PCA allowed us to reduce the dimensionality of this very large dataset. This gave us a deeper insight on the key variables in the dataset. This unsupervised learning tool is valuable, as the information generated from this model can be applied in supervised learning methods. From this model, 12 different principal components were generated. The graph shows that PC1 and PC2 explain a greater proportion of variance in the dataset than the other principal components do. This is the general trend, so it was expected these principal components would capture the most variance. In PC1, the variables with the greatest magnitude were total sulfur dioxide, free sulfur dioxide, and volatile acidity. For PC2 alcohol had the greatest magnitude. This gives insight on where the highest variance exists in the dataset, as the first PC attempts to account for the highest variance and then the second is the next highest, and so forth. 
```

```{r K Means Clustering}
wine = read.csv("C:/Users/Alisha/Desktop/wine.csv")
wine=wine[ , names(wine) != "color"]
library(tidyverse)
library(cluster)
library(factoextra)

wine <- scale(wine)
head(wine)
distance <- get_dist(wine)
set.seed(2)
km <- kmeans(wine, centers = 2)
km$cluster
#plot(wine, col = (km$cluster + 1), main = "K-Means Clustering Results with K =2", xlab = "", ylab = "", pch = 20, cex =2)

# get cluster means 
aggregate(wine ,by=list(km$cluster), FUN=mean)

# append cluster assignment
mydata <- data.frame(wine, km$cluster)

fit <- kmeans(mydata, 2)
library(cluster)
clusplot(mydata, fit$cluster, color=TRUE, shade=TRUE,
   labels=2, lines=0)

```

```{r}
#For this dataset, K Means Clustering was chosen over PCA to analyze different wines and their 11 associated chemical properties. K Means Clustering made more sense for this probloem as it will identify groups not explicity labeled in the data, which is exactly what we were testing. The goal of this unsupervised learning model was to see if these wines can be clustered based on similar properties. The 'color' column was removed, because we were trying to create a model that would correctly classify the wines as red or white. 
#The K Means Clusering model did correctly cluster some of the red and white wines, but it was not 100% accurate. To test how well our K Means Clustering model was at classifying red vs white wines, we added back the color column and studied if all the red wines and white wines were assigned the same cluster. It appeared that the red wines were correctly classified, but several of the white wines were not. Overall, this model was able to distinguish between red and white wine but did not have a perfect accuracy. 
#Finally, we tested if the K Means Clustering model was able to correctly distinguish between high and low quality wines. The study this, the clusters column and the quality columns were compared and there did not appear to be any clustering based on quality. For example, a wine rated as a 3 was clustered in the same cluster as wines getting a rating of 6+. Further tests could be run to study why this was occuring.
```
