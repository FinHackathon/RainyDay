###
# Libs
###
source("./database_require.R")

expense_categories <- c("Restaurants", "Markets", "Transportation", "Utilities (Monthly)", "Sports And Leisure", "Clothing And Shoes", "Rent Per Month", "Buy Apartment Price", "Salaries And Financing")
table_name<-"expense_categories"

df<-data.frame(cbind(1:length(expense_categories),expense_categories))
dimnames(df)[[2]]<-c("ID","expense_categories")
## Create an in HDD database
db <- dbConnect(SQLite(), dbname = DbFile)
ok <- dbWriteTable(db, table_name, df, row.names = FALSE, overwrite=TRUE)
stopifnot(ok)

# Verify
df_read<-dbReadTable(db, table_name);
stopifnot(sum(df_read!=df)==0)
