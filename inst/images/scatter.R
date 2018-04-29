png("scatterplot.png", 1000, 900)
set.seed(123131)
n = 10
#cols = sample(c("red", "blue"), 10, replace = TRUE)
y <- rnorm(n, 150)
plot(1:n, pch = "0", y, xlab = "Index", ylab = "Normal Values")
dev.off()
#saveRDS(z, "scatterplotValues.rds")
