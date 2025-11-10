movies <- data.frame(
  Title = c("The Shawshank Redemption","Inception","Parasite","Spirited Away","The Godfather","Interstellar","Whiplash"),
  Genre = c("Drama","Sci-Fi","Thriller","Animation","Crime","Sci-Fi","Drama"),
  Year  = c(1994,2010,2019,2001,1972,2014,2014),
  IMDB_Rating = c(9.3,8.8,8.6,8.6,9.2,8.7,8.5),
  stringsAsFactors = FALSE
)

# ---- Manual sort (selection sort) por columna ----
sort_manual <- function(df, key, decreasing=FALSE) {
  arr <- df
  n <- nrow(arr)
  for (i in 1:(n-1)) {
    target <- i
    for (j in (i+1):n) {
      if (decreasing) {
        if (arr[j, key] > arr[target, key]) target <- j
      } else {
        if (arr[j, key] < arr[target, key]) target <- j
      }
    }
    if (target != i) {
      tmp <- arr[i,]; arr[i,] <- arr[target,]; arr[target,] <- tmp
    }
  }
  arr
}

# ---- Manual filter ----
filter_manual <- function(df, predicate_fn) {
  keep <- c()
  for (i in 1:nrow(df)) {
    if (predicate_fn(df[i,])) keep <- c(keep, i)
  }
  df[keep, , drop=FALSE]
}

# ---- Integrado ----
sort_builtin <- function(df, key, decreasing=FALSE) {
  df[order(df[[key]], decreasing=decreasing), ]
}
filter_builtin <- function(df, predicate_fn) {
  # apply devuelve lógico por fila
  rows <- apply(df, 1, function(r) predicate_fn(as.list(r)))
  df[rows, , drop=FALSE]
}

# Predicados
pred_rating_gt_87 <- function(m) as.numeric(m$IMDB_Rating) > 8.7
pred_is_drama     <- function(m) m$Genre == "Drama"

# Demo
print(sort_manual(movies, "IMDB_Rating"))
print(sort_builtin(movies, "Year", TRUE))
print(filter_manual(movies, pred_rating_gt_87))
print(filter_builtin(movies, pred_is_drama))
