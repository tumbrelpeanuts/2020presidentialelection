Analysis of the 2020 Presidential Election
================
Alexander Sanchez
2030-01-01

[corr_simple()](https://towardsdatascience.com/how-to-create-a-correlation-matrix-with-too-many-variables-309cc0c0a57)

# Instructions and Expectations

Predicting voter behavior is complicated for many reasons despite the
tremendous effort in collecting, cleaning, analyzing, and understanding
many available datasets. As the midterm elections in the United States
is currently being held near the midpoint of the current president’s
four-year term of office, it is a good time for us to review the 2020
United States presidential election data! Despite that the 2016
presidential election came as a big surprise to many, Biden’s victory in
the 2020 presidential election has been widely predicted (e.g., see the
well-known Nate Silver in FiveThirtyEight).

# Data

We will start the analysis with two data sets. The first one is the
election data, which is drawn from here. The data contains county-level
election results.

The second dataset is the 2017 United States county-level census data,
which is available here.

The following code load in these two data sets: `election.raw` and
`census.`

# Exploratory Data Analysis

## Election Data

**1. (1 pts) Compute the total number of distinct values in state in
election.raw to verify that the data contains all states and a federal
district**

The following is the first few rows of the `election.raw` data.

    ## # A tibble: 6 × 5
    ##   state    county     candidate     party total_votes
    ##   <chr>    <chr>      <fct>         <fct>       <dbl>
    ## 1 Delaware Kent       Joe Biden     DEM         44552
    ## 2 Delaware Kent       Donald Trump  REP         41009
    ## 3 Delaware Kent       Jo Jorgensen  LIB          1044
    ## 4 Delaware Kent       Howie Hawkins GRN           420
    ## 5 Delaware New Castle Joe Biden     DEM        195034
    ## 6 Delaware New Castle Donald Trump  REP         88364

Checking dimensions of `election.raw` data set.

    ## [1] 32177     5

Checking for missing values in `election.raw` data set.

    ## [1] "There are no missing values"

Checking unique vlaues for each column

    ##       state      county   candidate       party total_votes 
    ##          51        2825          38          26        6762

## Census data

The following is the first few rows of the `census` data. The column
names are all very self-explanatory:

    ## # A tibble: 6 × 37
    ##   CountyId State  County TotalPop   Men  Women Hispanic White Black Native Asian
    ##      <dbl> <chr>  <chr>     <dbl> <dbl>  <dbl>    <dbl> <dbl> <dbl>  <dbl> <dbl>
    ## 1     1001 Alaba… Autau…    55036 26899  28137      2.7  75.4  18.9    0.3   0.9
    ## 2     1003 Alaba… Baldw…   203360 99527 103833      4.4  83.1   9.5    0.8   0.7
    ## 3     1005 Alaba… Barbo…    26201 13976  12225      4.2  45.7  47.8    0.2   0.6
    ## 4     1007 Alaba… Bibb …    22580 12251  10329      2.4  74.6  22      0.4   0  
    ## 5     1009 Alaba… Bloun…    57667 28490  29177      9    87.4   1.5    0.3   0.1
    ## 6     1011 Alaba… Bullo…    10478  5616   4862      0.3  21.6  75.6    1     0.7
    ## # ℹ 26 more variables: Pacific <dbl>, VotingAgeCitizen <dbl>, Income <dbl>,
    ## #   IncomeErr <dbl>, IncomePerCap <dbl>, IncomePerCapErr <dbl>, Poverty <dbl>,
    ## #   ChildPoverty <dbl>, Professional <dbl>, Service <dbl>, Office <dbl>,
    ## #   Construction <dbl>, Production <dbl>, Drive <dbl>, Carpool <dbl>,
    ## #   Transit <dbl>, Walk <dbl>, OtherTransp <dbl>, WorkAtHome <dbl>,
    ## #   MeanCommute <dbl>, Employed <dbl>, PrivateWork <dbl>, PublicWork <dbl>,
    ## #   SelfEmployed <dbl>, FamilyWork <dbl>, Unemployment <dbl>

**2. (1 pts) Report the dimension of `census`. (1 pts) Are there missing
values in the data set? (1 pts) Compute the total number of distinct
values in `county` in `census`. (1 pts) Compare the values of total
number of distinct county in `census` with that in `election.raw`. (1
pts) Comment on your findings.**

Checking dimensions of `census` data set.

    ## [1] 3220   37

Checking for missing values in `census` data set.

    ## [1] "There are missing values"

Which column has missing values?

    ## ChildPoverty 
    ##            1

    ## County 
    ##   1955

There are more distinct counties in `election.raw` than in `census`.
Grouping them by state and county (some states have the same county
names), `census` has around 3,220 counties, while `election.raw` has
4,633 counties. Upon closer examination of state and county, we see that
some counties are named differently despite being from the same state
county. Also, `census` has one more state than `election.raw` since
`census` includes Puerto Rico.

# Data Wrangling

**3. (4 pts) Construct aggregated data sets from election.raw data:
i.e.,**

- Keep the county-level data as it is in election.raw.
- Create a state-level summary into a election.state.
- Create a federal-level summary into a election.total.

<!-- -->

    ##      candidate  county   state total_votes
    ## 1 Donald Trump Autauga Alabama       19838
    ## 2 Jo Jorgensen Autauga Alabama         350
    ## 3    Joe Biden Autauga Alabama        7503
    ## 4    Write-ins Autauga Alabama          79
    ## 5 Donald Trump Baldwin Alabama       83544
    ## 6 Jo Jorgensen Baldwin Alabama        1229

    ##         candidate   state total_votes
    ## 1    Donald Trump Alabama     1441168
    ## 2    Jo Jorgensen Alabama       25176
    ## 3       Joe Biden Alabama      849648
    ## 4       Write-ins Alabama        7312
    ## 5    Brock Pierce  Alaska         825
    ## 6 Don Blankenship  Alaska        1127

**4. (1 pts) How many named presidential candidates were there in the
2020 election? (2 pts) Draw a bar chart of all votes received by each
candidate. You can split this into multiple plots or may prefer to plot
the results on a log scale. Either way, the results should be clear and
legible! (For fun: spot Kanye West among the presidential candidates!)**

There were about 36 presidential candidates in the 2020 election, not
counting write-ins and none of these candidates.

    ## There were 37 named presidential candidates in the 2020 election.

    ## # A tibble: 6 × 2
    ##   candidate          total_votes
    ##   <fct>                    <dbl>
    ## 1 Joe Biden             82046434
    ## 2 Donald Trump          74585705
    ## 3 Jo Jorgensen           1874183
    ## 4 Howie Hawkins           404835
    ## 5 Write-ins               254274
    ## 6 Rocky De La Fuente       88158

![](2020_presidential_election_files/figure-gfm/unnamed-chunk-19-1.png)<!-- -->![](2020_presidential_election_files/figure-gfm/unnamed-chunk-19-2.png)<!-- -->![](2020_presidential_election_files/figure-gfm/unnamed-chunk-19-3.png)<!-- -->![](2020_presidential_election_files/figure-gfm/unnamed-chunk-19-4.png)<!-- -->![](2020_presidential_election_files/figure-gfm/unnamed-chunk-19-5.png)<!-- -->![](2020_presidential_election_files/figure-gfm/unnamed-chunk-19-6.png)<!-- -->![](2020_presidential_election_files/figure-gfm/unnamed-chunk-19-7.png)<!-- -->![](2020_presidential_election_files/figure-gfm/unnamed-chunk-19-8.png)<!-- -->

**5. (6 pts) Create data sets county.winner and state.winner by taking
the candidate with the highest proportion of votes in both county level
and state level. Hint: to create county.winner, start with election.raw,
group by state and county, compute total votes, and pct = votes/total as
the proportion of votes. Then choose the highest row using top_n
(variable state.winner is similar).**

    ## # A tibble: 6 × 7
    ##   state                county           candidate party total_votes  total   pct
    ##   <chr>                <chr>            <fct>     <fct>       <dbl>  <dbl> <dbl>
    ## 1 delaware             kent             Joe Biden DEM         44552  87025 0.512
    ## 2 delaware             new castle       Joe Biden DEM        195034 287633 0.678
    ## 3 delaware             sussex           Donald T… REP         71230 129352 0.551
    ## 4 district of columbia district of col… Joe Biden DEM         39041  41681 0.937
    ## 5 district of columbia ward 2           Joe Biden DEM         29078  32881 0.884
    ## 6 district of columbia ward 3           Joe Biden DEM         39397  44231 0.891

    ## # A tibble: 6 × 5
    ##   state      candidate    party total_state_votes   pct
    ##   <chr>      <fct>        <fct>             <dbl> <dbl>
    ## 1 alabama    Donald Trump REP             1441168 0.620
    ## 2 alaska     Donald Trump REP              189892 0.485
    ## 3 arizona    Joe Biden    DEM             1672143 0.494
    ## 4 arkansas   Donald Trump REP              760647 0.624
    ## 5 california Joe Biden    DEM            11109764 0.635
    ## 6 colorado   Joe Biden    DEM             1804352 0.554

# Visualization

Visualization is crucial for gaining insight and intuition during data
mining. We will map our data onto maps.

The R package ggplot2 can be used to draw maps. Consider the following
code.

![](2020_presidential_election_files/figure-gfm/unnamed-chunk-22-1.png)<!-- -->

The variable states contain information to draw white polygons, and
fill-colors are determined by region.

**6. (4 pts) Use similar code to above to draw county-level map by
creating counties = map_data(“county”). Color by county.**

![](2020_presidential_election_files/figure-gfm/unnamed-chunk-23-1.png)<!-- -->

Now color the map by the winning candidate for each state. First,
combine states variable and state.winner we created earlier using
left_join(). Note that left_join() needs to match up values of states to
join the tables. A call to left_join() takes all the values from the
first table and looks for matches in the second table. If it finds a
match, it adds the data from the second table; if not, it adds missing
values:

Here, we’ll be combing the two data sets based on state name. However,
the state names in states and state.winner can be in different formats:
check them! Before using left_join(), use certain transform to make sure
the state names in the two data sets: states (for map drawing) and
state.winner (for coloring) are in the same formats. Then left_join().
Your figure will look similar to New York Times map. .winner, state)

![](2020_presidential_election_files/figure-gfm/unnamed-chunk-25-1.png)<!-- -->

**8. (6 pts) Color the map of the state of California by the winning
candidate for each county.**

![](2020_presidential_election_files/figure-gfm/unnamed-chunk-27-1.png)<!-- -->

**9. (4 pts) (Open-ended) Create a visualization of your choice using
census data.** Many exit polls noted that demographics played a big role
in the election. Use this Washington Post article and this R graph
gallery for ideas and inspiration.

    ## Warning: The `guide` argument in `scale_*()` cannot be `FALSE`. This was deprecated in
    ## ggplot2 3.3.4.
    ## ℹ Please use "none" instead.
    ## This warning is displayed once every 8 hours.
    ## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
    ## generated.

![](2020_presidential_election_files/figure-gfm/unnamed-chunk-28-1.png)<!-- -->

![](2020_presidential_election_files/figure-gfm/unnamed-chunk-29-1.png)<!-- -->

![](2020_presidential_election_files/figure-gfm/unnamed-chunk-32-1.png)<!-- -->

![](2020_presidential_election_files/figure-gfm/unnamed-chunk-33-1.png)<!-- -->

![](2020_presidential_election_files/figure-gfm/unnamed-chunk-34-1.png)<!-- -->

![](2020_presidential_election_files/figure-gfm/unnamed-chunk-36-1.png)<!-- -->

![](2020_presidential_election_files/figure-gfm/unnamed-chunk-37-1.png)<!-- -->

# Data Cleaning

We start by cleaning the county-level census data through several
transformations. Initially, we remove any rows with missing values using
`na.omit()` and `filter()`. Then, we convert three attributes (Men,
Employed, and VotingAgeCitizen) to percentages by dividing each by
TotalPop and multiplying by 100. The code creates a new Minority
attribute by combining Hispanic, Black, Native, Asian, and Pacific
populations and removes these original variables after creating the
Minority column using the `.keep = "unused" argument.` The Minority
column is then relocated to appear after the White column for better
organization.

The code removes several specified columns that are not needed for the
analysis: IncomeErr, IncomePerCap, IncomePerCapErr, Walk, PublicWork,
and Construction. Finally, we remove the TotalPop column.

``` r
census.clean <- census %>%
  na.omit() %>%
  filter(if_any(everything(), ~ !is.na(.))) %>%
  mutate(Men = (Men/TotalPop) * 100) %>%
  mutate(Women = (Women/TotalPop) * 100) %>%
  mutate(Employed = (Employed/TotalPop) * 100) %>%
  mutate(VotingAgeCitizen = (VotingAgeCitizen/TotalPop) * 100) %>%
  mutate(Minority = Hispanic + Black + Native + Asian + Pacific, .keep = "unused") %>% # remove columns used to create Minority
  relocate(Minority, .after = White) %>%
  select(-c(IncomeErr, IncomePerCap, IncomePerCapErr, Walk, PublicWork, Construction)) %>%
  select(-c(TotalPop)) 
  # select(-c(Drive,Poverty,ChildPoverty,Professional))

head(census.clean, 5)
```

    ## # A tibble: 5 × 26
    ##   CountyId State   County       Men Women White Minority VotingAgeCitizen Income
    ##      <dbl> <chr>   <chr>      <dbl> <dbl> <dbl>    <dbl>            <dbl>  <dbl>
    ## 1     1001 Alabama Autauga C…  48.9  51.1  75.4     22.8             74.5  55317
    ## 2     1003 Alabama Baldwin C…  48.9  51.1  83.1     15.4             76.4  52562
    ## 3     1005 Alabama Barbour C…  53.3  46.7  45.7     52.8             77.4  33368
    ## 4     1007 Alabama Bibb Coun…  54.3  45.7  74.6     24.8             78.2  43404
    ## 5     1009 Alabama Blount Co…  49.4  50.6  87.4     10.9             73.7  47412
    ## # ℹ 17 more variables: Poverty <dbl>, ChildPoverty <dbl>, Professional <dbl>,
    ## #   Service <dbl>, Office <dbl>, Production <dbl>, Drive <dbl>, Carpool <dbl>,
    ## #   Transit <dbl>, OtherTransp <dbl>, WorkAtHome <dbl>, MeanCommute <dbl>,
    ## #   Employed <dbl>, PrivateWork <dbl>, SelfEmployed <dbl>, FamilyWork <dbl>,
    ## #   Unemployment <dbl>

# Dimensionality reduction

After removing the State and County columns, the code creates a
two-column data frame called pc.county containing the first two
principal components (PC1 and PC2) from the PCA analysis of the cleaned
census data.

Regarding centering and scaling: The code uses both centering
`(center=TRUE)` and scaling `(scale=TRUE)` before running PCA, which is
appropriate because the variables in the census data have different
scales. For example, some variables are percentages, while others might
be raw counts or dollar values. Without scaling, variables with more
significant variances would dominate the principal components,
regardless of their importance.

``` r
pr.out.census <- prcomp(temp_census.clean, scale=TRUE, center = TRUE)
```

The three features with the largest absolute values of the first
principal component are:

Poverty, ChildPoverty, Employed

Several features have negative values in the first principal component,
including

Women, Minority, Poverty, ChildPoverty, Service, Office, Production,
Drive, Carpool, OtherTransp, MeanCommute, Unemployment

![](2020_presidential_election_files/figure-gfm/unnamed-chunk-44-1.png)<!-- -->

Notably, Poverty and ChildPoverty have negative signs and large
magnitudes. Features with opposite signs in the principal component
typically indicate a negative correlation between them. This means that
as one feature increases, the other tends to decrease. In this case, the
negative correlation suggests that counties with higher values in these
socioeconomic indicators tend to have lower values in other related
features.

For instance, counties with high poverty rates might be associated with
lower income levels, fewer job opportunities, and different commuting
patterns. The opposite signs in the first principal component capture
this underlying relationship in the data, showing how different
socioeconomic and demographic variables are interconnected.

## Determine the number of minimum number of PCs needed to capture 90% of the variance for the analysis

The code calculates the proportion of variance explained (PVE) for each
principal component by: 1. Extracting the standard deviations from the
principal component analysis 2. Calculating the variance by squaring the
standard deviations 3. Computing the proportion of variance by dividing
each component’s variance by the total variance

``` r
x <- pr.out.census$sdev
pr.var <- x^2
pve <- pr.var/sum(pr.var)
```

Computing `min(which(cumsum(pve) >= .9))`, we need about 12 PCs in order
to explain 90% of the total variation in the data. Thus, we need to
retain the first 15 components to explain at least 90% of the
variability in the original data.

The cumulative proportion of variance plot visually demonstrates how the
explained variance accumulates as more principal components are
included, allowing us to see the incremental contribution of each
additional component to the total variance explained.

![](2020_presidential_election_files/figure-gfm/unnamed-chunk-48-1.png)<!-- -->

# Clustering

### Centering and Scaling

Same approach as dimensionality reduction.

``` r
scar <- scale(census.clean[,c(-1:-3)], center=TRUE, scale=TRUE)
census.clean.dist <- dist(scar)
set.seed(123)
census.clean.hclust <- hclust(census.clean.dist)
```

### First Clustering (Original Features):

When performing hierarchical clustering using the scaled original
features with complete linkage and cutting the tree into 10 clusters,
the distribution of observations across clusters is quite uneven.
Cluster 1 contains the most observations, with 2,612 counties, while
several other clusters have very few counties. For instance, clusters 6
and 9 have only 6 and 5 counties, respectively, indicating that the
clustering algorithm identified a few very distinct groups among the
counties.

    ## clus
    ##    1    2    3    4    5    6    7    8    9   10 
    ## 2612   91    6  278  177   11    6   32    5    1

### Second Clustering (First Two Principal Components):

The cluster distribution changes significantly after re-running the
hierarchical clustering using the first two principal components from
pc.county. Cluster 1 contains 1,670 counties, cluster 7 has 648
counties, and Cluster 2 has 563 counties. The remaining clusters have
fewer counties, but the distribution differs from the first clustering.

    ## clus_new
    ##    1    2    3    4    5    6    7    8    9   10 
    ## 1022 1070   93   89  103  392   16    1  416   17

What can we take out of this

- Both clustering approaches result in highly imbalanced cluster sizes,
  suggesting some very distinct groups of counties.
- The uneven cluster sizes in both methods suggest that a few very
  distinct county groups stand out from the majority, which could
  represent counties with unique demographic or economic
  characteristics.

### The Elbow Method

![](2020_presidential_election_files/figure-gfm/unnamed-chunk-55-1.png)<!-- -->

# Classification

We start considering supervised learning tasks now. The most
interesting/important question to ask is: can we use census information
in a county to predict the winner in that county?

In order to build classification models, we first need to combine
county.winner and census.clean data. This seemingly straightforward task
is harder than it sounds. For simplicity, the following code makes
necessary changes to merge them into election.cl for classification.

**14. Understand the code above. (3 pts) Why do we need to exclude the
predictor party from election.cl?**

**Answer:** **Because of the statement: “can we use census information
in a county to predict the winner in that county?” The party predictor
informs us about the candidate’s party affiliation, not about the
county’s party affiliation. If the predictor variable party was about
the county, then we could possibly use it.**

# Classification

Using the following code, partition data into 80% training and 20%
testing:

Use the following code to define 10 cross-validation folds:

Using the following error rate function. And the object records is used
to record the classification performance of each method in the
subsequent problems.

**15. Decision tree: (2 pts) train a decision tree by cv.tree().** (2
pts) Prune tree to minimize misclassification error. Be sure to use the
folds from above for cross-validation. (2 pts) Visualize the trees
before and after pruning. (1 pts) Save training and test errors to
records object. (2 pts) Interpret and discuss the results of the
decision tree analysis. (2 pts) Use this plot to tell a story about
voting behavior.

Decision Tree purity

![](2020_presidential_election_files/figure-gfm/unnamed-chunk-61-1.png)<!-- -->

From our function `cv.tree()`, the best size is 5.

``` r
cv_data <- data.frame(
  size = cv.election$size,
  error = cv.election$dev
)

# Create the plot
ggplot(cv_data, aes(x = size, y = error)) +
  geom_line(linewidth = 0.8) +
  geom_point(size = 3) +
  theme_minimal() +
  labs(
    title = "Cross-Validation Error vs Tree Size",
    x = "Tree Size",
    y = "Cross-Validation Error"
  ) +
  theme(
    plot.title = element_text(hjust = 0.5, size = 14, face = "bold"),
    axis.title = element_text(size = 12),
    axis.text = element_text(size = 10),
    panel.grid.minor = element_blank()
  ) +
  scale_x_continuous(breaks = unique(cv_data$size)) +  # All tree sizes on x-axis
  geom_point(
    data = cv_data[which.min(cv_data$error), ],
    aes(x = size, y = error),
    color = "red",
    size = 4
  )  # Highlight minimum error point
```

![](2020_presidential_election_files/figure-gfm/unnamed-chunk-63-1.png)<!-- -->

![](2020_presidential_election_files/figure-gfm/unnamed-chunk-65-1.png)<!-- -->

**Both trees have Transit first followed by White and Women. Before
pruning, White was right below Women, but in after pruning, White is at
the very bottom of Women. Minority is still at the same place. In after
pruning, Professional is not in the White split, but Professional is
still in the Women split. Women is absent in the White split. Men is
also absent in the White split.**

**It seems White was a big contributing factor if you were going to vote
for Trump, while it seems Women was a big contributing factor if you
were going to vote for Biden.**

    ##               
    ## pred.test.tree Donald Trump Joe Biden
    ##   Donald Trump          464        26
    ##   Joe Biden              38        74

**16. (2 pts) Run a logistic regression to predict the winning candidate
in each county.** (1 pts) Save training and test errors to records
variable. (1 pts) What are the significant variables? (1 pts) Are they
consistent with what you saw in decision tree analysis? (2 pts)
Interpret the meaning of a couple of the significant coefficients in
terms of a unit change in the variables.

For interpretable machine learning

    ##                    Estimate Std. Error  z value  Pr(>|z|)
    ## (Intercept)      -3.614e+01  9.596e+00 -3.76657 1.655e-04
    ## Men               7.494e-02  5.092e-02  1.47177 1.411e-01
    ## White            -1.749e-01  6.947e-02 -2.51787 1.181e-02
    ## Minority         -3.736e-02  6.800e-02 -0.54948 5.827e-01
    ## VotingAgeCitizen  1.898e-01  2.722e-02  6.97507 3.057e-12
    ## Income           -7.805e-06  1.639e-05 -0.47627 6.339e-01
    ## Poverty           3.148e-02  4.325e-02  0.72786 4.667e-01
    ## ChildPoverty      1.439e-02  2.533e-02  0.56830 5.698e-01
    ## Professional      3.294e-01  3.855e-02  8.54408 1.296e-17
    ## Service           3.718e-01  4.828e-02  7.69947 1.366e-14
    ## Office            1.543e-01  4.692e-02  3.28830 1.008e-03
    ## Production        1.899e-01  4.179e-02  4.54413 5.516e-06
    ## Drive            -1.997e-01  4.951e-02 -4.03271 5.514e-05
    ## Carpool          -1.855e-01  6.089e-02 -3.04697 2.312e-03
    ## Transit           5.373e-02  1.001e-01  0.53708 5.912e-01
    ## OtherTransp      -2.734e-03  1.035e-01 -0.02642 9.789e-01
    ## WorkAtHome       -5.869e-02  7.187e-02 -0.81668 4.141e-01
    ## MeanCommute       5.043e-02  2.382e-02  2.11710 3.425e-02
    ## Employed          2.865e-01  3.425e-02  8.36541 5.991e-17
    ## PrivateWork       1.008e-01  2.170e-02  4.64750 3.360e-06
    ## SelfEmployed      8.590e-04  4.509e-02  0.01905 9.848e-01
    ## FamilyWork       -4.964e-01  2.901e-01 -1.71091 8.710e-02
    ## Unemployment      2.799e-01  5.037e-02  5.55713 2.743e-08

Below are the significant variables:

    ## Unemployment     Employed Professional      Service   FamilyWork 
    ##       0.2799       0.2865       0.3294       0.3718       0.4964

White is included, but Women and Minority are not among the top 5. It
does deviate from the Decision Tree analysis.

If were to increase Production by one unit, holding the rest fixed, then
applying the same logic to Professional, Employed, Service, and
Unemployment, we would get percent in the odds:

    ##   Production Unemployment     Employed Professional      Service 
    ##        20.91        32.30        33.18        39.01        45.03

**17. You may notice that you get a warning glm.fit: fitted
probabilities numerically 0 or 1 occurred.** As we discussed in class,
this is an indication that we have perfect separation (some linear
combination of variables perfectly predicts the winner). This is usually
a sign that we are overfitting. One way to control overfitting in
logistic regression is through regularization.

(3 pts) Use the cv.glmnet function from the glmnet library to run a
10-fold cross validation and select the best regularization parameter
for the logistic regression with LASSO penalty. Set lambda = seq(1, 50)
\* 1e-4 in cv.glmnet() function to set pre-defined candidate values for
the tuning parameter λ.

(1 pts) What is the optimal value of λ in cross validation? (1 pts) What
are the non-zero coefficients in the LASSO regression for the optimal
value of λ? (1 pts) How do they compare to the unpenalized logistic
regression? (1 pts) Comment on the comparison. (1 pts) Save training and
test errors to the records variable.

The optimal value of $\lambda$ in cross validation is 0.0011.

Below are the non-zero coefficients in the LASSO regression for the
optimal value of λ:

    ##      (Intercept)              Men            Women            White 
    ##       -3.446e+01        2.584e-02       -8.838e-15       -1.260e-01 
    ## VotingAgeCitizen          Poverty     Professional          Service 
    ##        1.791e-01        4.838e-02        2.679e-01        3.054e-01 
    ##           Office       Production            Drive          Carpool 
    ##        1.075e-01        1.301e-01       -1.424e-01       -1.200e-01 
    ##          Transit      OtherTransp      MeanCommute         Employed 
    ##        1.036e-01        3.025e-02        2.831e-02        2.457e-01 
    ##      PrivateWork     SelfEmployed       FamilyWork     Unemployment 
    ##        8.855e-02       -1.517e-02       -4.299e-01        2.456e-01

``` r
set.seed(20)

# Predict probabilities for training and test datasets
prob.training <- predict(lasso.model, type = "response", s = bestlam, newx = x.train)
prob.test <- predict(lasso.model, type = "response", s = bestlam, newx = x.test)

# Generate predictions using majority rule
majority_rule <- 0.5
pred_training <- ifelse(prob.training > majority_rule, "Joe Biden", "Donald Trump")
pred_test <- ifelse(prob.test > majority_rule, "Joe Biden", "Donald Trump")
```

``` r
# Training set confusion matrix and error calculation
training_pred_table <- table(Predicted = pred_training, True = election.tr$candidate)
percent_train <- sum(diag(training_pred_table)) / nrow(election.tr) * 100

# Test set confusion matrix and error calculation
test_pred_table <- table(Predicted = pred_test, True = election.te$candidate)
percent_test <- sum(diag(test_pred_table)) / nrow(election.te) * 100
```

Unpenalized logistic regression: When taking their absolute values,
Women and Income had low coefficients compared to the rest of the
variables. Excluding these two, the other variables were within range of
each other.

LASSO regression: Minority, Income, WorkAtHome, and MeanCommute had zero
coefficients.

It does seem Income is not an important metric. White has been
consistently shown as being an important variable.

**18. (6 pts) Compute ROC curves for the decision tree, logistic
regression and LASSO logistic regression using predictions on the test
data.** Display them on the same plot. (2 pts) Based on your
classification results, discuss the pros and cons of the various
methods. (2 pts) Are the different classifiers more appropriate for
answering different kinds of questions about the election?

![](2020_presidential_election_files/figure-gfm/before-random-1.png)<!-- -->

**Answer:**

**Answer: **

# Taking it further

This part will be worth up to a 20% of your final project grade!

**19. (9 pts) Explore additional classification methods.** Consider
applying additional two classification methods from KNN, LDA, QDA, SVM,
random forest, boosting, neural networks etc. (You may research and use
methods beyond those covered in this course). How do these compare to
the tree method, logistic regression, and the lasso logistic regression?

### Random Forest

### Neural Net

    ##  [1] "candidate"        "Men"              "Women"            "White"           
    ##  [5] "Minority"         "VotingAgeCitizen" "Income"           "Poverty"         
    ##  [9] "ChildPoverty"     "Professional"     "Service"          "Office"          
    ## [13] "Production"       "Drive"            "Carpool"          "Transit"         
    ## [17] "OtherTransp"      "WorkAtHome"       "MeanCommute"      "Employed"        
    ## [21] "PrivateWork"      "SelfEmployed"     "FamilyWork"       "Unemployment"

    ## Loading required package: foreach

    ## 
    ## Attaching package: 'foreach'

    ## The following objects are masked from 'package:purrr':
    ## 
    ##     accumulate, when

    ## Loading required package: iterators

    ## Aggregating results
    ## Selecting tuning parameters
    ## Fitting size = 7, decay = 0.5 on full training set

    ## Warning: Setting row names on a tibble is deprecated.

![](2020_presidential_election_files/figure-gfm/unnamed-chunk-91-1.png)<!-- -->

![](2020_presidential_election_files/figure-gfm/unnamed-chunk-93-1.png)<!-- -->

![](2020_presidential_election_files/figure-gfm/unnamed-chunk-94-1.png)<!-- -->

**Answer:**

**Plotting the ROC Curve for all the methods, we see that our CV
Decision Tree performs the worst, then Random Forest. After that, it’s a
matter of personal preference. Random Forest does outperform CV Decision
Tree throughout the ROC Curve. In my opinion Decision Tree and Random
Forest would not be suitable for our problem since we already narrowed
it down to two candidates. I still think LASSO Logistic Regression is
the most optimal, followed by our regular Logistic Regression.**

**20. (9 pts) Tackle at least one more interesting question. Creative
and thoughtful analysis will be rewarded!** Some possibilities for
further exploration are:

- Conduct an exploratory analysis of the “purple” counties – the “battle
  ground” / “swing counties”: which the models predict Biden and Trump
  were roughly equally likely to win. What is it about these counties
  that make them hard to predict?

Arizona, Florida, Michigan, Pennsylvania, Wisconsin New Hampshire, North
Carolina, Georgia, and Minnesota are swing states (battle ground
states). “arizona”, “florida”, “michigan”, “pennsylvania”, “wisconsin”,
“new hampshire”, “north carolina”, “minnesota”, “georgia”. “Arizona”,
“Florida”, “Michigan”, “Pennsylvania”, “Wisconsin”, “New Hampshire”,
“North Carolina”, “Minnesota”, “Georgia”

[Voter turnout in United States presidential
elections](https://en.wikipedia.org/wiki/Voter_turnout_in_United_States_presidential_elections)

**Answer: I will use voter turnout as % of VAP**

**As the maps illustrate, Joe Biden won 7/9 battle ground states while
Trump won 2/9. If we were to compare this to the 2016 election, Trump
won Arizona, Wisconsin, Pennsylvania, Michigan, Georgia. All these
states flipped for the 2020 election, which Biden ended up winning the
2020 election.**

**One of the difficulties of predicting these counties/states is that
future events such as war, natural disasters, pandemics are
unpredictable. The COVID-19 pandemic drastically altered the 2020
election since voting became a lot easier to do. The 2016 election had a
voter turnout of 54.8%, but the 2020 election had a voter turnout of
62.0%. The 2008 election had a voter turnout of 57.1%, but the 2012
election had a voter turnout of 53.8%. Unlike the 2012 run of Obama, the
2020 run of Trump saw an increase in voter turnout, but at the detriment
of Trump.**

**Below are a list of articles and research papers on census if you are
interested. In my opinion, these are important finding that will
determine future elections:**

[The Male Non-Working Class A Disquieting
Survey](https://www.milkenreview.org/articles/the-male-non-working-class)

[GOP favored by married people, Dems strongly supported by unmarried
women, exit polls
show](https://katv.com/news/nation-world/gop-favored-by-married-people-while-dems-strongly-supported-by-unmarried-women-exit-polls)

[All the Single Democratic
Ladies](https://www.aei.org/op-eds/all-the-single-democratic-ladies/)

[Rising Share of U.S. Adults Are Living Without a Spouse or
Partner](https://www.pewresearch.org/social-trends/2021/10/05/rising-share-of-u-s-adults-are-living-without-a-spouse-or-partner/)

[In Changing U.S. Electorate, Race and Education Remain Stark Dividing
Lines](https://www.pewresearch.org/politics/2020/06/02/in-changing-u-s-electorate-race-and-education-remain-stark-dividing-lines/)

[Turnout in 2020 election spiked among both Democratic and Republican
voting groups, new census data
shows](https://www.brookings.edu/research/turnout-in-2020-spiked-among-both-democratic-and-republican-voting-groups-new-census-data-shows/)

[Latinos support Democrats over Republicans 2-1 in House and Senate
elections](https://www.brookings.edu/blog/fixgov/2022/11/11/latinos-support-democrats-over-republicans-2-1-in-house-and-senate-elections/)

[Are Latinos becoming more Republican? Or just more
American](https://thehill.com/opinion/campaign/3715068-are-latinos-becoming-more-republican-or-just-more-american/)

[The new swing vote: Why more Latino voters are joining the
GOP](https://www.csmonitor.com/USA/Politics/2022/1021/The-new-swing-vote-Why-more-Latino-voters-are-joining-the-GOP)

[The Latino vote shifted toward Republicans in 2020. Will it
again?](https://www.washingtonpost.com/politics/interactive/2022/election-2022-latino-voters/)
