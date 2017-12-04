# lutilities

This is a set of operators and trivial functions I use in every `R` program. The major goal of these operators is to extend the infix language from `dplyr`, to have partial evaluations, `T` pipe operators, infix string concatination, and function composition


# Install

```R
library(devtools)
devtools::install_github("probinso/lutilities", force=T)
library(lutilities)

```

# Examples
```R
read.tsv = partial(
  read.delim, sep='\t',
  row.names=1, header=T, check.names = F)
  
rowCov = function(mat) rowSds(mat) / rowMeans(mat)
colCoV = t %|% rowCov

rnorm(1000, mean=3, sd=1) %T% list(sigma=sd, mu=mean)
```
