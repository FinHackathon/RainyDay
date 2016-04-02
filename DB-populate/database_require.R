require(RSQLite) # Database
###
# Connect
###
db <- dbConnect(SQLite(), dbname = DbFile)
expense_categories_table_name<-"expense_categories"
countries_table_name<-"countries"
cities_table_name<-"cities"
user_pass_table_name <- "user_pass"
expense_categories_table_name<-"expense_categories"
expenses_table_name<-"expenses"