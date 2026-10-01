# ggplot2 example

Example of a **ggplot2** image.

``` r

library(ggplot2)

# Count rows or sums of weights.
g <- ggplot(mpg, aes(class))
# Number of cars in each class.
g + geom_bar()
```

![Bar chart of vehicle counts by class in the fuel economy dataset.
Vehicle class is on the horizontal axis and count on the vertical axis.
SUVs are the largest group, with 62 vehicles, and two-seaters are the
smallest, with 5. ](ggplot2_files/figure-html/setup-1.png)

A ggplot2 image
