
library(factoextra)

# Step 1: Hierarchical clustering on the original data
scar <- scale(census.clean[,c(-1:-3)], center=TRUE, scale=TRUE)
census.clean.dist <- dist(scar)
set.seed(123)
census.clean.hclust <- hclust(census.clean.dist)

# Step 2: Hierarchical clustering using the first 2 principal components
census_transform <- as.data.frame(pc.county)
census_transform.dist <- dist(census_transform)
set.seed(123)
census_transform.hclust <- hclust(census_transform.dist)

# Step 3: Compute gap statistic
set.seed(123)
fviz_gap_stat_pca <- fviz_nbclust(census_transform, FUN = hcut, method = "gap_stat", nstart = 25, k.max = 10)

# Step 4: Plot the gap statistic
print(fviz_gap_stat_pca)s




####### Average Silhouette Method for Optimal Number of Clusters
avg_silhouette <- sapply(2:15, function(k) {
  clusters <- cutree(hclust_result, k)
  sil <- silhouette(clusters, distance_matrix)
  avg_sil <- summary(sil)$avg.width
  return(avg_sil)
})

# Prepare data for ggplot
avg_silhouette_data <- data.frame(k = 2:15, avg_silhouette = avg_silhouette)

# Plotting Average Silhouette Width vs. Number of Clusters using ggplot
avg_silhouette <- ggplot(avg_silhouette_data, aes(x = k, y = avg_silhouette)) +
  geom_point() +
  geom_line() +
  labs(title = "Average Silhouette Method",
       x = "Number of Clusters (k)",
       y = "Average Silhouette Width") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5))

elbow_method / avg_silhouette



# From problem 16

set.seed(20) 
Test_Prob <- election.te %>%
  mutate(preda1=as.factor(ifelse(prob.test>0.5, "Joe Biden", "Donald Trump")))

training_pred_table <- table(pred=Test_Prob$preda1, true=Test_Prob$candidate)
training_pred_table
percent_train <- sum(diag(training_pred_table)) / nrow(Test_Prob) * 100






####### From problem 18



######################### Old Code #############################################
plot(roc_perf_tree, colorize = FALSE,  type="l",col="green", lty=1)
plot(roc_perf_log, colorize = FALSE, add = TRUE, type="l",col="blue", lty=2)
plot(roc_perf_lasso, colorize = FALSE, add = TRUE,  type="l", lty=3, col="red")
# legend(.7, .45, legend=c("Tree","Log", "Lasso"),
#        col=c("green","blue", "red"), lty=c(1,3), cex=0.8)
legend("bottomright", legend=c("Tree", "Log", "Lasso"),
       col=c("green", "blue", "red"), lty=c(1, 2, 3), cex=0.8)
abline(a = 0, b = 1, lwd = 3, lty = 2, col = 1)

################################################################################

roc_data <- data.frame(
  FPR = c(unlist(roc_perf_tree@x.values), unlist(roc_perf_log@x.values), unlist(roc_perf_lasso@x.values)),
  TPR = c(unlist(roc_perf_tree@y.values), unlist(roc_perf_log@y.values), unlist(roc_perf_lasso@y.values)),
  Model = factor(rep(c("Tree", "Log", "Lasso"), times = c(length(roc_perf_tree@x.values[[1]]),
                                                          length(roc_perf_log@x.values[[1]]),
                                                          length(roc_perf_lasso@x.values[[1]]))))
)


# Creating the ROC plot
ggplot(roc_data, aes(x = FPR, y = TPR, color = Model, linetype = Model)) +
  geom_line(linewidth = 1) +
  geom_abline(intercept = 0, slope = 1, linetype = "dashed", color = "black") +
  scale_color_manual(values = c("green", "blue", "red")) +
  labs(title = "ROC Curve Comparison",
       x = "False Positive Rate (FPR)",
       y = "True Positive Rate (TPR)",
       color = "Model") +
  theme_minimal() +
  theme(legend.position = "bottomright")


ggplot(roc_data, aes(x = FPR, y = TPR, color = Model, linetype = Model)) +
  geom_line(size = 1) +
  geom_abline(intercept = 0, slope = 1, linetype = "dashed", color = "black") +
  scale_color_manual(values = c("green", "blue", "red")) +
  labs(title = "ROC Curve Comparison",
       x = "False Positive Rate", # (FPR)
       y = "True Positive Rate", # (TPR)
       color = "Model",
       linetype = "Model") +
  #theme_minimal() +
  theme_classic() +
  theme(plot.title = element_text(hjust = 0.5)) +
  theme(legend.position = "bottom") # Positions legend at the bottom


ggplot(roc_data, aes(x = FPR, y = TPR, color = Model, linetype = Model)) +
  geom_line(size = 1) +
  geom_abline(intercept = 0, slope = 1, linetype = "dashed", color = "black") +
  scale_color_manual(values = c("green", "blue", "red")) +
  labs(title = "ROC Curve Comparison",
       x = "False Positive Rate (FPR)",
       y = "True Positive Rate (TPR)",
       color = "Model",
       linetype = "Model") +
  #theme_minimal() +
  theme_classic() +
  theme(plot.title = element_text(hjust = 0.5)) +
  theme(legend.position = c(0.8, 0.2)) # Adjusts to "bottomright" within the plot area




## Random Forest and Boosting

plot(roc_perf_randfor, colorize = FALSE,  type="l",col="red")
abline(a = 0, b = 1, lwd = 3, lty = 2, col = 1)


plot(roc_perf_boost, colorize = FALSE,  type="l",col="red")
abline(a = 0, b = 1, lwd = 3, lty = 2, col = 1)

plot(roc_perf_randfor, colorize = FALSE,  type="l",col="green")
abline(a = 0, b = 1, lwd = 3, lty = 2, col = 1)
plot(roc_perf_boost, colorize = FALSE, add = TRUE,  type="l", lty=3, col="red")
legend(.7, .45, legend=c("Random Forest","Boosting"),
       col=c("green","red"), lty=c(1,3), cex=0.8)

### graph including random forest and boosting

plot(roc_perf_tree, colorize = FALSE,  type="l",col="green", lty = 1)
plot(roc_perf_log, colorize = FALSE, add = TRUE, type="l",col="blue", lty = 2)
plot(roc_perf_lasso, colorize = FALSE, add = TRUE,  type="l", col="red", lty=3)
plot(roc_perf_randfor, colorize = FALSE, add = TRUE,  type="l",col="purple", lty=4)
plot(roc_perf_boost, colorize = FALSE, add = TRUE,  type="l", col="black", lty=5)
legend(.7, .45, legend=c("Tree","Log", "Lasso","Random Forest","Boosting"),
       col=c("green","blue", "red","purple","black"), lty=c(1,5), cex=0.8)
abline(a = 0, b = 1, lwd = 3, lty = 2, col = 1)




