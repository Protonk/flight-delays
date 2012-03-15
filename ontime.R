library(stringr)

convertFact <- function(data, input = colnames(data), output.name = "Converted Factor", new.lab = NULL, transform = TRUE) {
  nfact <- length(input)
  if (is.null(new.lab)) labels <- input
  else labels <- new.lab
  stopifnot(rowSums(data[, input]) <= 1)
  bin.subset <- as.matrix(data[, input]); colnames(bin.subset) <- labels
  if (transform) {
    tryCatch(stopifnot(is.data.frame(data)), finally = print("Tansformed object must be a Data Frame"))
    data[, output.name] <- factor(bin.subset %*% 1:ncol(bin.subset),levels = 1:ncol(bin.subset), labels = colnames(bin.subset))
    data[, !names(data) %in% input]
  }
  else factor(bin.subset %*% 1:ncol(bin.subset),levels = 1:ncol(bin.subset), labels = colnames(bin.subset))
}
cheapTime <- function(chartime) {
  # getting back to minutes
  # cheaptime - (cheaptime %/% 60) * 60
  # getting back to hours
  # cheaptime %/% 60
  split.time <- as.numeric(str_sub(chartime, c(0,3), c(2, 4)))
  min.mat <- t(matrix(split.time, 2, length(split.time)))
  min.mat[, 1]*60 + min.mat[, 2]
}

input.class <- c(rep(c("character", "numeric"), 2), rep("character", 2), "numeric", "character", rep("numeric", 5))

ontime <- read.csv("~/Downloads/ontimejan.csv", colClasses = input.class, nrows = 494401)
ontime[, "FL_DATE"] <- as.Date(ontime[, "FL_DATE"], format = "%Y-%m-%d")
ontime[, "Origin"] <- factor(ontime[, "ORIGIN"])
ontime[, "Destination"] <- factor(ontime[, "DEST"])

# added nonsense because "not diverted" and "not cancelled" doesn't have a column.

status.lvl <- cbind(round(!(ontime[, "DIVERTED"] | ontime[, "CANCELLED"])), 
                    as.matrix(ontime[, c("DIVERTED", "CANCELLED")]))
colnames(status.lvl) <- c("Normal", "Diverted", "Cancelled")
ontime[, "Status"] <- convertFact(status.lvl, transform = FALSE)

ontime[, "Departure Time"] <- cheapTime(ontime[, "CRS_DEP_TIME"])
ontime[, "Arrival Time"] <- cheapTime(ontime[, "CRS_ARR_TIME"])






# Clean up columns. 
ontime <- ontime[, !names(ontime) %in% c("DIVERTED", "CANCELLED", "ORIGIN", "DEST", "CRS_ARR_TIME", "CRS_DEP_TIME")]

#Nice way to subset the df and avoid NA strings
completed.ind <- !ontime[, "Status"] %in% c("Cancelled")

# Clean up objects
remove(status.lvl, input.class, convertFact)



# airportdata <- read.csv("~/Downloads/Airportsdata.csv")





