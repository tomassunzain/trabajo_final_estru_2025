Sales <- data.frame(
  InvoiceID    = c("750-67-8428","226-31-3081","631-41-3108","123-19-1176","373-73-7910"),
  City         = c("Yangon","Mandalay","Yangon","Naypyitaw","Mandalay"),
  CustomerType = c("Member","Normal","Normal","Member","Member"),
  Gender       = c("Female","Male","Male","Female","Female"),
  ProductLine  = c("Health and beauty","Electronic accessories","Home and lifestyle","Sports and travel","Food and beverages"),
  Total        = c(74.26,15.28,46.33,58.22,33.08),
  stringsAsFactors = FALSE
)

# --- Manual (sin which/ subset/ filter para el núcleo de búsqueda) ---
search_seq <- function(df, predicate_fn) {
  if (is.null(df) || nrow(df) == 0) return(list(results = df[0,], status = "EMPTY"))
  idx <- c()
  for (i in 1:nrow(df)) {
    if (predicate_fn(df[i,])) idx <- c(idx, i)
  }
  if (length(idx) == 0) return(list(results = df[0,], status = "NOT_FOUND"))
  list(results = df[idx, , drop=FALSE], status = "OK")
}

by_city         <- function(city) function(r) r$City == city
by_productline  <- function(pl)   function(r) r$ProductLine == pl
by_gender       <- function(g)    function(r) r$Gender == g
by_customertype <- function(ct)   function(r) r$CustomerType == ct

cases <- list(
  list("City=Yangon", by_city("Yangon")),
  list("ProductLine=Food and beverages", by_productline("Food and beverages")),
  list("Gender=Male", by_gender("Male")),
  list("CustomerType=VIP", by_customertype("VIP"))
)

for (c in cases) {
  res <- search_seq(Sales, c[[2]])
  cat("[MANUAL]", c[[1]], ": status=", res$status, ", invoices=", paste(res$results$InvoiceID, collapse=", "), "\n", sep="")
}

# Integrado (para comparar): usar subset o filter (dplyr)
builtin <- subset(Sales, City == "Yangon")
cat("[BUILTIN] City=Yangon -> ", paste(builtin$InvoiceID, collapse=", "), "\n", sep="")

# Stub CSV:
# Sales <- read.csv("supermarket_sales.csv", stringsAsFactors = FALSE)
