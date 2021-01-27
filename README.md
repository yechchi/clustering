# clustering

### Authors : EL HAJAM Nawel -- YECHCHI Sif-Eddine -- KOUA Richard

#### M2 DATA SCIENCE PARIS SACLAY UNIVERSITY

> [Quick Start](#qs)

> [The clustering algorithm](#com)

> [Time complexity](#time)


## Quick Start:

The 'clustering' R package is implemented in R and in Rcpp. It contains 3 functions: dist.R , Ward.R and hclust.R .

clustering algorithm by Ward Distance is of time complexity ***O*(*n*<sup>3</sup>)**. The improved solution (by Lance & Williams process) is of  ***O*(*n*<sup>2</sup>log(n))**

This gif provides a graphical representation of its mechanisms:

![](hierarchical.gif)
### Package installation:

We install the package from Github:

``` r
#devtools::install_github("yechchi/clustering")
library(M2algorithmique)
```

### A first simple test:

We simulate 

``` r
```
