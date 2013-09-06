## Figures

![plot of chunk data_clean](figure/data_clean1.png) 

```
## Error: object 'predator.occur.matrix' not found
```

![plot of chunk data_clean](figure/data_clean2.png) 


Statistics on euclidian distance results:

```
## 
## Call:
## lm(formula = pred_abd_matrix[lower.tri(pred_abd_matrix)] ~ pred_phylo_matrix[lower.tri(pred_phylo_matrix)])
## 
## Residuals:
##      Min       1Q   Median       3Q      Max 
## -0.10130 -0.06906  0.00181  0.06564  0.11830 
## 
## Coefficients:
##                                                 Estimate Std. Error
## (Intercept)                                     9.48e-02   1.71e-02
## pred_phylo_matrix[lower.tri(pred_phylo_matrix)] 2.06e-05   2.45e-05
##                                                 t value Pr(>|t|)    
## (Intercept)                                        5.55    3e-07 ***
## pred_phylo_matrix[lower.tri(pred_phylo_matrix)]    0.84      0.4    
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 0.0707 on 89 degrees of freedom
## Multiple R-squared:  0.00784,	Adjusted R-squared:  -0.00331 
## F-statistic: 0.703 on 1 and 89 DF,  p-value: 0.404
```

```
## $z.stat
## [1] 6328
## 
## $p
## [1] 0.561
## 
## $alternative
## [1] "two.sided"
```


Statistics on correlation results:


```
## 
## Call:
## lm(formula = pred_cor_matrix[lower.tri(pred_cor_matrix)] ~ pred_phylo_matrix[lower.tri(pred_phylo_matrix)])
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -0.5484 -0.2371 -0.0235  0.2030  0.6499 
## 
## Coefficients:
##                                                  Estimate Std. Error
## (Intercept)                                      0.326564   0.073392
## pred_phylo_matrix[lower.tri(pred_phylo_matrix)] -0.000209   0.000105
##                                                 t value Pr(>|t|)    
## (Intercept)                                        4.45  2.5e-05 ***
## pred_phylo_matrix[lower.tri(pred_phylo_matrix)]   -1.98     0.05 .  
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 0.304 on 89 degrees of freedom
## Multiple R-squared:  0.0424,	Adjusted R-squared:  0.0316 
## F-statistic: 3.94 on 1 and 89 DF,  p-value: 0.0503
```

```
## $z.stat
## [1] 9428
## 
## $p
## [1] 0.241
## 
## $alternative
## [1] "two.sided"
```




![FALSE](figure/phyloimage.pdf) 







```
## Error: object 'dist.mat' not found
```

## Figure 1
similarity between predators in diet composition in food web trials, as predicted by phylogenetic distance. 















