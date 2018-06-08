mtcars

pr_comps <- princomp (mtcars, cor = TRUE)
rot_matrix <- loadings (pr_comps)
biplot (pr_comps)

data ("heptathlon", package = "HSAUR")

heptathlon
heptathlon$hurdles <- max(heptathlon$hurdles) - heptathlon$hurdles
heptathlon$run200m <- max(heptathlon$run200m) - heptathlon$run200m
heptathlon$run800m <- max(heptathlon$run800m) - heptathlon$run800m

round (cor (heptathlon [, -8]), 2)
heptathlon_pca <- prcomp (heptathlon[, -8], scale = TRUE)
center <- heptathlon_pca$center
scale <- heptathlon_pca$scale
cor(heptathlon$score, heptathlon_pca$x[,1])

heptathlon_pca$x
