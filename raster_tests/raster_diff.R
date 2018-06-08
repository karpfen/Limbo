library (spatstat)
library (fields)
library (jpeg)
library (magrittr)

picture_orig <- readJPEG ("pizza_cat.jpg")
pic_band_1 <- picture_orig [, , 1]

blur_sig_3 <- as.matrix (blur (as.im (pic_band_1), sigma = 3))
# blur_sig_6 <- as.matrix (blur (as.im (pic_band_1), sigma = 6))

image.plot (pic_band_1)
image.plot (blur_sig_3)
# image.plot (blur_sig_6)

diffs_3_1 <- blur_sig_3 - pic_band_1
# diffs_1_3 <- pic_band_1 - blur_sig_3
# diffs_6_3 <- blur_sig_6 - blur_sig_3
# diffs_6_1 <- blur_sig_6 - pic_band_1

image.plot (diffs_3_1)
# image.plot (diffs_6_3)
# image.plot (diffs_6_1)

e_threshold <- quantile (diffs_3_1, probs = 0.95) %>% as.numeric
edge_mask <- ifelse (diffs_3_1 > e_threshold, 1, 0)
image.plot (edge_mask, col = terrain.colors (2))

nrow_mask <- nrow (edge_mask)
ncol_mask <- ncol (edge_mask)
m_row <- seq_len (nrow_mask)
m_col <- seq_len (ncol_mask)

cluster_sizes <- matrix (0, nrow = nrow_mask, ncol = ncol_mask)

n_cluster <- 1

for (i in m_row)
{
    for (j in m_col)
    {
        if (edge_mask [i, j] == 1)
        {
            mni <- ifelse (i > 1, i - 1, 1)
            mxi <- ifelse (i < nrow_mask, i + 1, nrow_mask)
            mnj <- ifelse (j > 1, j - 1, 1)
            mxj <- ifelse (j < ncol_mask, j + 1, ncol_mask)

            cluster_sizes [i, j] <- n_cluster
            cluster_sizes [mni, mnj] <- ifelse (cluster_sizes [mni, mnj] > 0, cluster_sizes [i, j], 0)
            cluster_sizes [mni, j] <- ifelse (cluster_sizes [mni, j] > 0, cluster_sizes [i, j], 0)
            cluster_sizes [mni, mxj] <- ifelse (cluster_sizes [mni, mxj] > 0, cluster_sizes [i, j], 0)
            cluster_sizes [i, mnj] <- ifelse (cluster_sizes [i, mnj] > 0, cluster_sizes [i, j], 0)
            cluster_sizes [i, mxj] <- ifelse (cluster_sizes [i, mxj] > 0, cluster_sizes [i, j], 0)
            cluster_sizes [mxi, mnj] <- ifelse (cluster_sizes [mxi, mnj] > 0, cluster_sizes [i, j], 0)
            cluster_sizes [mxi, j] <- ifelse (cluster_sizes [mxi, j] > 0, cluster_sizes [i, j], 0)
            cluster_sizes [mxi, mxj] <- ifelse (cluster_sizes [mxi, mxj] > 0, cluster_sizes [i, j], 0)

            n_cluster <- n_cluster + 1
        }
    }
}


image.plot (cluster_sizes)
