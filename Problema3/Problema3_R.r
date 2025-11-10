UnitPrice <- c(74.69,15.28,46.33,58.22,33.08)
Quantity  <- c(7,5,3,8,4)
Total     <- c(516.83,76.40,138.99,465.76,132.32)

mean_ <- function(x) mean(x)
stddev <- function(x) sqrt(sum((x-mean_(x))^2)/(length(x)-1))
covar  <- function(x,y) sum((x-mean_(x))*(y-mean_(y)))/(length(x)-1)
corr   <- function(x,y) covar(x,y)/(stddev(x)*stddev(y))

manual <- matrix(0,3,3)
cols <- list(UnitPrice, Quantity, Total)
names <- c("UnitPrice","Quantity","Total")

for(i in 1:3) for(j in 1:3) manual[i,j] <- corr(cols[[i]], cols[[j]])
colnames(manual) <- rownames(manual) <- names
print("Manual correlation matrix:")
print(round(manual,4))

# --- Integrada ---
builtin <- cor(data.frame(UnitPrice, Quantity, Total))
print("Builtin cor():")
print(round(builtin,4))
