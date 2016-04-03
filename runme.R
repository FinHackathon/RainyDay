# Important set path to the directory of this file
setwd(path.expand("~/skroutz"))

#Global Paths
DbFile <- "./Data/sql-lite/RainyDaySQLite.sqlite"
csv_path <- "./Data/csv-prototyping"
original_path <- "./Data/original"

db_populate_path <- "./DB-populate"

source(paste(db_populate_path,"/sqlite-password.R",sep=""))
source(paste(db_populate_path,"/sqlite-countries.R",sep=""))
source(paste(db_populate_path,"/sqlite-expenses-categories.R",sep=""))
source(paste(db_populate_path,"/sqlite-expenses.R",sep=""))
